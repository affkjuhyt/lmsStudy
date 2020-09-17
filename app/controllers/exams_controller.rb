class ExamsController < ApplicationController
  before_action :load_lesson

  def index
    @exam = current_user.exams.all
  end

  def create
    @exam = current_user.exams.build(exam_params)
    @user_course = current_user.user_courses.find_by course_id: @lesson.course.id
    point = 0
    @course = @lesson.course
    params[:exam][:answers_attributes].each do |param|
      if QuestionChoice.find(param.last[:choice]).right_answer == true
        point += 1
      end
    end
    respond_to do |format|
      if point >= @lesson.questions.length
        @exam.point = point
        @exam.save && (@user_course.update(lesson_step: @user_course.lesson_step + 1) if @lesson)
        format.html { redirect_to(course_path(@course)) }
        format.js
      else
        format.html { redirect_to(course_path(@course)) }
        format.js
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
