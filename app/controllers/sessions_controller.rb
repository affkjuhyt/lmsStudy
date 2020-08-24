class SessionsController < Devise::SessionsController
  before_action :set_search

  private

  def set_search
    @q = Category.ransack params[:q]
    @categories = @q.result.page(params[:page])
  end
end
