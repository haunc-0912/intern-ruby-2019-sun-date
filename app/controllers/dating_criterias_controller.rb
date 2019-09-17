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

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @success = @user.update user_params
    @user_next = User.get_suggest_user(@user).first

    respond_to :js
  end

  private

  def user_params
    params.require(:user).permit DatingInformation::DATING_INFOR_PARAMS
  end

  def load_user
    @user = current_user
  end
end
