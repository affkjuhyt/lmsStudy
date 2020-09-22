class SendNotiJob < ApplicationJob
  queue_as :default

  def perform(course)
    categories = course.category_ids
    categories.each do |category|
      course_categories = CourseCategory.where(category_id: category)
      course_category_ids = course_categories.ids
      course_category_ids.each do |course_category_id|
        course_cate = course_categories.find_by(id: course_category_id).course
        user_noti = course_cate.user
        Notification.create(recipient: user_noti, actor: current_user, action: 'created', notifiable: course)
      end
    end
  end
end
