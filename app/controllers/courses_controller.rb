class CoursesController < ApplicationController
  before_action :get_course, only: [:show]
  before_action :set_search, only: [:index, :show]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index; end

  def show; end

  private

  def set_search
    @q = Course.ransack params[:q]
    @courses = @q.result(distinct: true).page(params[:page])
  end

  def get_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :overview, :description, :image)
  end
end
