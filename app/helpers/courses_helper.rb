module CoursesHelper
  def course_registered_by_user?(course_id)
    return unless current_user
    current_user.user_course_ids.include?(course_id)
  end
end
