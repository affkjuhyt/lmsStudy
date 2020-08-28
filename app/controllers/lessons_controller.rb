class LessonsController < ApplicationController
  before_action :load_course

  def show
    @lesson = @course.lessons.find(params[:id])
    @user_course = current_user.user_courses.find_by(course_id: @lesson.course_id)
    @questions = @lesson.questions
    @question = @questions.find(params[:id])
    @max_point = @questions.length
    @exam = current_user.exams.build
    @result = current_user.exams.find_by(lesson_id: params[:id])
    @exam.answers.build
    # @question_choice = @question.question_choices.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  private

  def load_course
    @course = Course.find(params[:course_id])
  end
end
