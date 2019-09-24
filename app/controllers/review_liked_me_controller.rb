class ReviewLikedMeController < ApplicationController
  before_action :load_passive_user, except: %i(show index)

  def show
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t "match.no_user"
    redirect_to review_liked_me_index_path
  end

  def index
    @users = User.info_user_like_me(current_user).page(params[:page]).per Settings.page
  end

  def react
    reaction = current_user.send(@react.to_sym, @pass_user)

    if reaction && reaction.like?
      broadcast_notification reaction, Settings.noti_key.like, current_user, @pass_user

      if current_user.is_match? @pass_user
        @match = true
        broadcast_notification reaction, Settings.noti_key.match, current_user, @pass_user
        broadcast_notification reaction, Settings.noti_key.match, @pass_user, current_user
      end
    end
    @users = User.info_user_like_me(current_user).page(params[:page]).per Settings.page
    respond_to :js
  end

  private

  def load_passive_user
    return unless params.values_at(:passive_user_id, :react).all?(&:present?)
    @pass_user = User.find_by id: params[:passive_user_id]
    @react = params[:react]
  end
end
