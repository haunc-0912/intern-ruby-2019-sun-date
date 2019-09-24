class MatchesController < ApplicationController
  def index
    session[:conversations] ||= []
    @search = User.ransack(params[:q])
    @users = @search.result.info_user_match(current_user).page(params[:page]).per Settings.page
    @conversations = Conversation.by_user current_user
  end

  def show
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "match.no_user"
    redirect_to matches_path
  end
end
