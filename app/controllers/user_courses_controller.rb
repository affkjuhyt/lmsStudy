class UserCoursesController < ApplicationController
  before_action :get_user_course, only: [:update]

  def create
    @user_course = current_user.user_courses.create(course_id: params[:course_id])
    @course = Course.find params[:course_id]
    redirect_to @course
  end

  def update
    @lesson = @course.lessons.find_by(course_id: @user_course.course_id, sequence: params[:user_course][:lesson_step])
    @user_course.update user_courses_params
    respond_to do |format|
      if @user_course.save
        format.js { @lesson = @course.lessons.find_by course_id: @user_course.course_id, sequence: @user_course.lesson_step }
      end
    end
  end

  private

  def get_user_course
    @user_course = UserCourse.find(params[:id])
  end

  def user_courses_params
    params.require(:user_course).permit(:lesson_step)
  end
end
