class Course < ApplicationRecord
  belongs_to :user
  has_many :course_categories
  has_many :user_courses, dependent: :destroy
  has_many :review_courses, dependent: :destroy

  validates :user_id, :title, :overview, :description, presence: true
end
