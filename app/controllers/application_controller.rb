class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale
    set_param_locale params[:locale] if params[:locale].present?
    I18n.locale = cookies[:locale] || I18n.default_locale
  end
end
