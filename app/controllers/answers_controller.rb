class AnswersController < ApplicationController
  before_action :load_lesson

  def create
  end

  private

  def load_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
end
