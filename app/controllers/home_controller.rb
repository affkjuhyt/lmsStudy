class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
    @courses = Course.all.paginate(page: params[:page], per_page: Settings.search.per_page)
  end

  def about
  end
end
