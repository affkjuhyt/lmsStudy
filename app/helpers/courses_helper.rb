module CoursesHelper
  def course_registered_by_user?(course_id)
    return unless user_signed_in?
    UserCourse.where(course_id: course_id, user_id: current_user.id).exists?
  end
end
