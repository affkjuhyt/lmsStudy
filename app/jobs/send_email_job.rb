class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(course)
    CourseMailer.course_email(course).deliver_later
  end
end
