class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
    @q = Category.ransack params[:q]
    @categories = @q.result.paginate(page: params[:page], per_page: Settings.search.per_page)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def about; end
end
