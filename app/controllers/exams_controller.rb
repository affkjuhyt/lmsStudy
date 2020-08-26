class ExamsController < ApplicationController
  def index
    @exam = current_user.exams.all
  end

  def create
    @exam = current_user.exams.build(exam_params)
    @exam.save
  end

  def show
  end

  private

  def exam_params
    params.require(:exam).permit(:user_id, :lesson_id, answers_attributes: [:question_id, :question_choice_id])
  end
end
