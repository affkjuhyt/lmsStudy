module CoursesHelper
  def is_admin?
    return unless current_user
    current_user.is_admin?
  end

  def course_registered_by_user?(course_id)
    return unless current_user
    current_user.user_courses.where(course_id: course_id).exists?
  end

  def course_rated_by_user?(course_id)
    return unless current_user
    current_user.rate_ids.include?(course_id)
  end
end
