
class Category < ApplicationRecord
  has_many :questions, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  validates_with Concerns::NastyCharValidator

  scope :in_order, -> { order :name }

  scope :query, -> { in_order.includes(:questions) }

  def to_s
    name
  end

  def questions_count
    questions.size
  end

  def answers_count
    questions.joins(:answers).count
  end
end

