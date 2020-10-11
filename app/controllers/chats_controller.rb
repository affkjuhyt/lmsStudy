class ChatsController < ApplicationController
  def index
    if current_user.is_admin?
      @users = User.all
    else
      @users = User.all
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
end
