class RatesController < ApplicationController
  before_action :load_course

  def save_rate
    @rate = current_user.rates.find_or_create_by(course_id: params[:course_id])
    @rate.discarded? ? @rate.undiscard : @rate.discard
    respond_to do |format|
      format.js do
        @success = @rate.discarded?
        @course_id = params[:course_id]
        @course_rates = @course.total_rate_count
      end
    end
  end

  private

  def load_course
    @course = Course.find(params[:course_id])
  end
end
