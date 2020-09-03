class Admin::CoursesController < Admin::BaseController
  before_action :load_course, only: [:show, :edit, :update, :destroy]

  def index
    @result = Course.ransack params[:q]
    @courses = @result.result(distinct: true).order(created_at: :desc).paginate(page: params[:page], per_page: Settings.users.per_page)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @course = Course.new
  end

  def show; end

  def create
    @course = Course.new(course_params)
    @course.user_id = current_user.id
    respond_to do |format|
      if @course.save
        format.html { redirect_to admin_courses_path, notice: 'The course has been created' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.js
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
    SendEmailJob.perform_later @course
  end

  private

  def load_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :overview, :description, :image)
  end
end
