class MatchesController < ApplicationController
  def index
    @search = User.ransack(params[:q])
    @users = @search.result.info_user_match current_user.id
  end

  def show
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "match.no_user"
    redirect_to matches_path
  end
end
