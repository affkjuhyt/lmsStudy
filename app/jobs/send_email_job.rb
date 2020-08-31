class SendEmailJob < ApplicationJob
  queue_as :default

  def perform course
<<<<<<< HEAD
    CourseMailer.course_email(course).deliver_now
=======
     CourseMailer.welcome_email(course).deliver_now
>>>>>>> Send mail background job
  end
end
