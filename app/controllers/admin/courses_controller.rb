class Admin::CoursesController < ApplicationController
  before_action :get_course, only: [:show, :edit, :update, :destroy]

  def create
    @course = Course.new(course_params)
    @course.user_id = current_user.id
    respond_to do |format|
      if @course.save
        format.html { redirect_to admin_courses_path, notice: 'The course has been created' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.js
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
    SendEmailJob.set(wait: 5.minutes).perform_later @course
  end

  private

  def get_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :overview, :description, :image)
  end
end
