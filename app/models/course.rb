class Course < ApplicationRecord
  belongs_to :user
  mount_uploader :image, CourseImageUploader
  has_many :course_categories
  has_many :user_courses, dependent: :destroy
  has_many :review_courses, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :lessons, dependent: :destroy

  validates :user_id, :title, :overview, :description, presence: true

  accepts_nested_attributes_for :lessons, allow_destroy: true
end
