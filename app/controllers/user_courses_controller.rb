class UserCoursesController < ApplicationController
  before_action :get_user_course, only: [:update]

  def create
    @user_course = UserCourse.create(course_id: params[:course_id], user_id: current_user.id)
    @course = Course.find params[:course_id]
    @user_courses = @course.user_courses.order('created_at DESC')
    redirect_to @course
  end

  def update
    @user_course = UserCourse.find_by id: params[:id]
    @user_course.update user_courses_params
    respond_to do |format|
      if @user_course.save
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
