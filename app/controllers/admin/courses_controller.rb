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
    @lesson = @course.lessons.build
    @lesson.questions.build.question_choices.build
  end

  def edit
    @lessons = @course.lessons.sort_by(&:sequence)
  end

  def show
    @lessons = @course.lessons
    @review_courses = @course.review_courses.order('created_at DESC')
                              .paginate(page: params[:page], per_page: Settings.search.per_page)
    @user_courses = @course.user_courses.order('created_at DESC')
                              .paginate(page: params[:register_page], per_page: Settings.user_courses.per_page)
  end

  def create    
    @course = Course.new(course_params)
    @course.user_id = current_user.id
    respond_to do |format|
      if @course.save
        format.html { redirect_to admin_courses_path, notice: 'The course has been created' }
        format.json { render :show, status: :created, location: @course }
        SendEmailJob.perform_later @course
      else
        format.html { render :new }
        format.js
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to admin_courses_path, notice: 'Updated' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.js
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to admin_courses_path, notice: 'Course destroyed' }
      format.json { head :no_content }
    end
  end

  private

  def load_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :overview, :description, :image,
                            lessons_attributes: [:id, :sequence, :lesson_type, :name, :video_url, :check_point, :_destroy, 
                            questions_attributes: [:id, :title, :_destroy, question_choices_attributes: [:id, :right_answer, :answer, :_destroy]]])
  end
end
