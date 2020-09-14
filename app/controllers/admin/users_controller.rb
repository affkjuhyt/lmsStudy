class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: [:show, :edit, :update]

  def index
    @result = User.ransack params[:q]
    @users = @result.result(distinct: true).order(created_at: :desc).not_admin
                    .paginate(page: params[:page], per_page: Settings.users.per_page)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @courses = @user.courses
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: 'Created user' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: 'User updated' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :avatar, :email, :password, :confirmed_at)
  end
end
