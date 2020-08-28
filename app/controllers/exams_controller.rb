class ExamsController < ApplicationController
  before_action :load_lesson

  def index
    @exam = current_user.exams.all
  end

  def create
    @questions = @lesson.questions
    @exam = current_user.exams.build(exam_params)
    @point = 0
    params[:exam][:answers_attributes].each do |param|
      if(QuestionChoice.find(param.last[:choice]).right_answer == true)
        @point++
      end
    end
    respond_to do |format|
      if @exam.save
        format.html { render '_result', notice: 'Exam was successfully.' }
        format.js { render '_result' }
      else
        format.html
        format.js { render '_fail' }
      end
    end
  end

  def show; end

  private

  def load_lesson
    @lesson = Lesson.find(params[:exam][:lesson_id])
  end

  def exam_params
    params.require(:exam).permit(:id, :lesson_id, answers_attributes: [:choice])
  end
end
