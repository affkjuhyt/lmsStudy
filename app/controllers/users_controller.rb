class UsersController < ApplicationController
  before_action :get_user

  private

  def get_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :email)
  end
end
