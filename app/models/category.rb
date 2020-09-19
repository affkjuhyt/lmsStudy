class Category < ApplicationRecord
  has_many :course_categories
  has_many :courses, through: :course_categories

  mount_uploader :image, CategoryImageUploader
end
