class Rate < ApplicationRecord
  include Discard::Model
  belongs_to :course
  belongs_to :user

  validates_uniqueness_of :course_id, scope: :user_id

  after_discard do
    course.increment(:total_rate_count).save
  end

  after_undiscard do
    course.decrement(:total_rate_count).save
  end
end
