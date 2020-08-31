class CourseMailer < ApplicationMailer
  def course_email course
    @user = User.find(user_id)
    @course = course
    mail(to: @user.email, subject: 'New course')
  end
end
