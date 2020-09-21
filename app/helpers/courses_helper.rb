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

  def percent(user, course)
    lesson_step = course.user_courses.find_by(user_id: user.id).lesson_step
    size = course.lessons.size
    percent = (lesson_step.to_f / size) * 100
    percent.round(2)
  end

  def status_success(user, course)
    lesson_step = course.user_courses.find_by(user_id: user.id).lesson_step
    size = course.lessons.size
    percent = (lesson_step.to_f / size) * 100
    percent.round(2)
    return false unless percent >= 100
  end
end
