class Lesson < ApplicationRecord
  belongs_to :course

  validates :lesson_type, :sequence, :name, presence: true
  validates :name, length: { maximum: 14 }
  validates :check_point, numericality: { only_integer: true, greater_than_or_equal_to: 2 }, presence: true
  validates :video_url, presence: true
  enum lesson_type: Settings.lesson_type.to_h
end
