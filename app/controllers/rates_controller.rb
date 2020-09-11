class RatesController < ApplicationController
  before_action :load_course

  def save_rate
    if current_user.user_course_ids.include? @course.id
      @rate = current_user.rates.find_or_create_by(course_id: params[:course_id])
      @rate.discarded? ? @rate.undiscard : @rate.discard
      respond_to do |format|
        format.js do
          @success = @rate.discarded?
          @course_id = params[:course_id]
          @course_rates = @course.total_rate_count
        end
      end
    else
      flash.now[:alert] = 'Hay dang ki de vote'
    end
  end

  private

  def load_course
    @course = Course.find(params[:course_id])
  end
end
