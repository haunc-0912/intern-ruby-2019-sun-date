class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: Settings.fb) if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user
      flash[:success] = t "google.flash.success"
      session["devise.google_data"] = request.env["omniauth.auth"].except(:extra)
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:danger] = t "google.flash.error"
      redirect_to sign_in_path
    end
  end
end
