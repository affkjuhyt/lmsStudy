class ReviewCoursesController < ApplicationController

  before_action :load_course, only: [:create, :edit, :update]
  before_action :get_review_course, only: [:edit, :update, :destroy]

  def create
    @review_course = current_user.review_courses.build(review_params)
    if @review_course.save
      respond_to do |format|
        format.html { redirect_to @review_course }
        format.js { render layout: false }
      end
    else
      redirect_to root_path
    end
  end

  def edit
    respond_to do |format|
      format.html { redirect_to @review_course }
      format.js { render layout: false }
    end
  end

  def update
    @course = @review_course.course
    respond_to do |format|
      if @review_course.update(review_params)
        format.html
        format.js { render layout: false }
      end
    end
  end

  def destroy
    @review_course.destroy
    respond_to do |format|
      format.html { redirect_to review_courses_url, notice: 'Comment was successfully destroyed.' }
      format.js { render layout: false }
    end
  end

  private

  def load_course
    @course = Product.find_by(id: params[:comment][:course_id])
  end

  def review_params
    params.require(:review_course).permit(:user_id, :course_id, :comment)
  end

  def get_review_course
    @review_course = @course.review_courses.find(params[:id])
  end
end
