class Exam < ApplicationRecord
  belongs_to :lesson
  has_many :answers

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  validates_associated :answers
end
