class Lesson < ApplicationRecord
  belongs_to :course

  has_many :questions, dependent: :destroy
  has_many :exams, dependent: :destroy
  validates :lesson_type, :sequence, :name, presence: true
  validates :name, length: { maximum: 14 }
  validates :check_point, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, presence: true
  validates :video_url, presence: true
  enum lesson_type: Settings.lesson_type.to_h
end
