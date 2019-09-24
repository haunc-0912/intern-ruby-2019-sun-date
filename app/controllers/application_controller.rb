class ApplicationController < ActionController::Base
  include DatingCriteriasHelper
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_notifications, if: :user_signed_in?

  def set_locale
    set_param_locale params[:locale] if params[:locale].present?
    I18n.locale = cookies[:locale] || I18n.default_locale
  end

  def load_notifications
    @notifications = Notification.by_user current_user
  end

  def broadcast_notification reaction, key, active_user, passive_user
    notification = reaction.create_activity key: key, owner: active_user, recipient: passive_user
    NotificationBroadcastJob.perform_now Notification.by_user(passive_user).size, notification
  end

  def redirect_if_no_infor
    return unless current_user.dating_information.blank? || current_user.dating_information.is_no_infor?

    flash[:notice] = t "flash.require_set"
    redirect_to after_signup_path :set_dating_profile
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :account_update, keys: %i(reset_password_token)
    devise_parameter_sanitizer.permit :sign_up, keys: %i(name avatar)
  end
end
