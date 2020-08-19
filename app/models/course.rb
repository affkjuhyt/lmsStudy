class Course < ApplicationRecord
  belongs_to :user
  has_many :course_categories
  has_many :user_courses, dependent: :destroy

  validates :user_id, :course_title, :course_overview, :course_description, :course_type_id, presence: true
end
