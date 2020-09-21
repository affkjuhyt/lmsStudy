class CourseMailer < ApplicationMailer
  def course_email(course)
    users = User.all
    @course = course
    users.each do |x|
      mail(to: x.email, subject: 'New course')
    end
  end
end
