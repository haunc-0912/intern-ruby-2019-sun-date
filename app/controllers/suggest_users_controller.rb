class SuggestUsersController < ApplicationController
  before_action :load_passive_user, except: :show

  def show
    @user = User.get_suggest_user(current_user).first
  end

  def react
    reaction = current_user.send(@react.to_sym, @pass_user)
    if reaction && reaction.status.to_sym == :like
      broadcast_notification reaction, Settings.noti_key.like, current_user, @pass_user
      if current_user.is_match? @pass_user
        @match = true
        broadcast_notification reaction, Settings.noti_key.match, current_user, @pass_user
        broadcast_notification reaction, Settings.noti_key.match, @pass_user, current_user
      end
    end
    @user_next = User.get_suggest_user(current_user).first
    respond_to :js
  end

  private

  def load_passive_user
    return unless params.values_at(:passive_user_id, :react).all?(&:present?)
    @pass_user = User.find_by id: params[:passive_user_id]
    @react = params[:react]
  end
end
