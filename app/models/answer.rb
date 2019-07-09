
class Answer < ApplicationRecord
  belongs_to :question

  after_initialize { self.active = true if active.nil? }

  validates :reply, presence: true

  validates_with Concerns::NastyCharValidator

  scope :activated, -> (is_active=true) { where active: is_active }

  scope :in_order, -> { order :reply }

  def to_s
    reply
  end
end
