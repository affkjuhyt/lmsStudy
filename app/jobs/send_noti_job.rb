class SendNotiJob < ApplicationJob
  queue_as :default

  def perform(course)
    course_ids = CourseCategory.select(:course_id).where(category_id: course.category_ids)
    user_ids = UserCourse.select(:user_id).where(course_id: course_ids)
    Notification.create(recipient: user_ids, actor: current_user, action: 'created', notifiable: course)
  end
end
