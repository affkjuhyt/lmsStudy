class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :set_search
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include ApplicationHelper

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def set_search
    @q = Category.ransack params[:q]
    @categories = @q.result.page(params[:page])
  end

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
