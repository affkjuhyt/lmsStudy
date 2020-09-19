class Lesson < ApplicationRecord
  belongs_to :course

  has_many :questions, dependent: :destroy
  has_many :exams, dependent: :destroy

  validates :lesson_type, :sequence, :name, presence: true
  validates :name, length: { maximum: Settings.lesson_name.maximum }
  validates :check_point, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, presence: true

  accepts_nested_attributes_for :questions, allow_destroy: true
  enum lesson_type: Settings.lesson_type.to_h
end
