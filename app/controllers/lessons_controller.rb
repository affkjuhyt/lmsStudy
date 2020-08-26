class LessonsController < ApplicationController
  before_action :load_lesson

  def show
    @user_course = current_user.user_courses.find_by(course_id: @lesson.course_id)
    respond_to do |format|
      format.js
    end
  end

  private

  def load_lesson
    @lesson = Lesson.find(params[:id])
  end
end
