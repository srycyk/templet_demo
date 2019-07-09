
class Question < ApplicationRecord
  PER_PAGE = 10

  FUTURE_RANGE = Date.today + 1 .. Date.today + 999
  PAST_RANGE = Date.today - 999 .. Date.today

  belongs_to :category

  has_many :answers, dependent: :destroy

  after_initialize { self.active = true if active.nil? }

  validates :query, :category, presence: true

  validates_with Concerns::NastyCharValidator

  scope :no_expiry, -> { where expires_on: nil }

  scope :unexpired, -> { where expires_on: FUTURE_RANGE }

  scope :expired, -> { where expires_on: PAST_RANGE }

  scope :activated, -> (is_active=true) { where active: is_active }

  scope :ready, -> { activated.no_expiry.or unexpired }

  scope :disused, -> { activated(false).or where.not(expires_on: nil).expired }

  scope :search, -> q { where 'query LIKE ?', "%#{q}%" }

  # Scope methods
  class << self
    def in_order(field_name)
      case field_name
      when 'recent'
        order updated_at: :desc, query: :asc
      when 'active'
        order :active, :query
      when 'expires_on'
        order expires_on: :desc, query: :asc
      else
        order field_name.presence || :query
      end
    end

    def query(order_by, page, search_for)
      relation = in_order(order_by).includes(:answers)

      relation = relation.search search_for if search_for.present?

      relation.page(page) #.per(PER_PAGE)
    end

    def with_answers
      joins(:answers)
        .includes(:category, :answers)
        .order('categories.name, questions.query')
        .ready
        .sort_by(&method(:ordering))
    end

    def latest
      order(updated_at: :desc).limit(1)
    end

    private

    def ordering(question)
      [ question.category.name, -question.answers.size, question.query ]
    end
  end

  def to_s
    query
  end

  def answers_count
    answers.size
  end

  def expired?
    expires_on and not expires_on.future?
  end

  def in_disuse?
    not active or expired?
  end

  def reinstate
    update expires_on: nil, active: true
  end
end

