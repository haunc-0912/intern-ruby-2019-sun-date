class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    set_param_locale params[:locale] if params[:locale].present?
    I18n.locale = cookies[:locale] || I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_in, keys: %i(email password)
  end
end
