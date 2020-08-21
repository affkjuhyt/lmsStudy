class CoursesController < ApplicationController
  before_action :get_course, only: [:index, :show]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @courses = Course.all.paginate(page: params[:page], per_page: Settings.search.per_page)
  end

  def show; end

  private

  def get_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :overview, :description, :image)
  end
end
