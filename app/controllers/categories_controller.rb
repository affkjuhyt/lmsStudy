class CategoriesController < ApplicationController
  before_action :get_category, only: [:show]
  before_action :set_search, only: [:index, :show]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index; end

  def show
    @courses = Course.where(id: CourseCategory.find(params[:id]).id)
  end

  private

  def set_search
    @q = Category.ransack params[:q]
    @categories = @q.result(distinct: true).page(params[:page])
  end

  def get_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
