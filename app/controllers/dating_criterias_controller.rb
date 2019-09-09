class DatingCriteriasController < ApplicationController
  before_action :load_user, except: :search_location

  def search_location
    if params[:search_content].present?
      results = Geocoder.search params[:search_content]
      results.map! {|i| {id: i.address, name: i.address}}
      render json: {results: results.as_json}
    end
  end

  def edit
    @user.build_dating_information unless @user.dating_information.present?
  end

  def update
    if @user.update user_params
      flash[:info] = t "flash.update_success"
      redirect_to edit_dating_criterias_path
    else
      flash[:danger] = t "flash.update_fail"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit dating_information_attributes: %i(prefer_gender start_age end_age dating_location dating_distance)
  end

  def load_user
    @user = current_user
  end
end
