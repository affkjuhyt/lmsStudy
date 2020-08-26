class UserCoursesController < ApplicationController
  before_action :get_user_course, only: [:update]

  def create
    @user_course = current_user.user_courses.create(course_id: params[:course_id])
    @course = Course.find params[:course_id]
    redirect_to @course
  end

  def update
    @user_course.update user_courses_params
    @user_course.save
  end

  private

  def get_user_course
    @user_course = UserCourse.find(params[:id])
  end

  def user_courses_params
    params.require(:user_course).permit(:lesson_step)
  end
end
