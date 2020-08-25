class LessonsController < ApplicationController
  before_action :load_course

  def show
    @lesson = @course.lessons.find(params[:id])
    @user_course = current_user.user_courses.find_by(course_id: @lesson.course_id)
    respond_to do |format|
      format.js
    end
  end

  private

  def load_course
    @course = Course.find(params[:id])
  end
end
