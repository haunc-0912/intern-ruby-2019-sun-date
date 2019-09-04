class ReviewBlockedUsersController < ApplicationController
  def show
    @user = User.info_user_block(current_user)
  end

  def react
    @react = Reaction.find_by(active_user_id: current_user, passive_user_id: params[:passive_user_id])

    return unless @react
    @react.destroy
    @user_next = User.info_user_block(current_user)
    respond_to :js
  end
end
