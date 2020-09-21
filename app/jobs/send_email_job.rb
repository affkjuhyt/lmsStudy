class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(course)
    CourseMailer.course_email(course).deliver_now
  end
end
