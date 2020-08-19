class CoursesController < ApplicationController
  before_action :get_course, only: [:show]
  before_action :set_search, only: [:index, :show]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index; end

  def show
    @review_courses = @course.review_courses.order('created_at DESC').paginate(page: params[:comment_page], per_page: 6)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_search
    @q = Course.ransack params[:q]
    @courses = @q.result.page(params[:page])
  end

  def get_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :overview, :description, :image)
  end
end
