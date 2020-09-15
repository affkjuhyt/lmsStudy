module UsersHelper
  def percent_success course, users
    @cnt = 0
    @users.each do |user|
      @lesson_step = user.user_courses.find_by(course_id: course.id).lesson_step
      if @lesson_step == @lessons.size
        @cnt += 1
      end
    end

    @register = course.total_register_count
    @percent = (@cnt.to_f / @register) * 100
    @percent.round(2)
  end
end
