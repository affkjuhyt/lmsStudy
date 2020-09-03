class CoursesController < ApplicationController
  before_action :load_course, only: [:show]
  before_action :set_search, only: [:index, :show]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index; end

  def show
    @review_courses = @course.review_courses.paginate(page: params[:page], per_page: Settings.search.per_page)
    @lessons = @course.lessons.order('sequence ASC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_search
    @q = Course.ransack params[:q]
    @courses = @q.result.paginate(page: params[:page], per_page: Settings.search.per_page)
  end

  def load_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :overview, :description, :image)
  end
end
