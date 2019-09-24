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

  def destroy
    react = Reaction.find_by active_user_id: current_user, passive_user_id: params[:id]

    return unless react
    react.destroy
    redirect_to matches_path
  end
end
