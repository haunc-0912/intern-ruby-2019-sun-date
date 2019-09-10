class DatingInformationsController < ApplicationController
  before_action :load_user, only: %i(new create)

  def new
    @user.build_dating_information unless @user.dating_information.present?
  end

  def create
    if @user.update user_params
      flash[:success] = t "dating.flash.success"
      redirect_to root_path
    else
      flash[:danger] = t "dating.flash.error"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def load_user
    @user = current_user
  end
end
