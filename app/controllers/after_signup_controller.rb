class AfterSignupController < ApplicationController
  include Wicked::Wizard
  before_action :load_user, only: %i(show update)

  steps :set_dating_profile, :set_dating_citeria

  def show
    render_wizard
  end

  def update
    @user.current_step = step
    @user.dating_information.current_step = step

    case step
    when :set_dating_profile
      @user.assign_attributes params_dating_infor
    when :set_dating_citeria
      @user.assign_attributes params_dating_citeria
    end
    sign_in @user, bypass: true
    render_wizard @user
  end

  def finish_wizard_path
    flash[:success] = t "flash.setting_done"
    suggest_users_path
  end

  private

  def load_user
    @user = current_user
    @user.build_dating_information unless @user.dating_information.present?
  end

  def params_dating_citeria
    params.require(:user).permit DatingInformation::DATING_INFOR_PARAMS
  end

  def params_dating_infor
    params.require(:user).permit User::USER_PARAMS
  end
end
