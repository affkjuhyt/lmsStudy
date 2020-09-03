class Admin::BaseController < ApplicationController
  before_action :check_admin
  layout "admin/admin_index"

  def index
    @count_user = User.count
    @count_courses = Course.count
  end

  private

  def check_admin
    unless current_user.is_admin?
      redirect_to root_path
      flash[:alert] = "You cannot access this page"
    end
  end
end
