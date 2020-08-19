class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_authorization

  private

  def check_authorization
    unless authorization
      flash[:notice] = 'Vui long xac thuc email'
      redirect_to root_url
    end
  end
end
