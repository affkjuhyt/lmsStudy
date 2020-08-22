class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
    @q = Category.ransack params[:q]
    @categories = @q.result(distinct: true).page(params[:page])
  end

  def about
  end
end
