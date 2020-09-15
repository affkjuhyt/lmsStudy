class UsersController < ApplicationController
  before_action :load_user
  before_action :authenticate_user!
  before_action :check_authorization

  private

  def load_user
    @user = User.find(params[:id])
  end

  def check_authorization
    unless authorization
      flash[:notice] = t('devise.permission')
      redirect_to root_url
    end
  end

  def authorization
    (current_user.id == @user.id) || current_user.is_admin?
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :email)
  end
end
