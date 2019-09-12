class SuggestUsersController < ApplicationController
  before_action :load_passive_user, except: :show

  def show
    @user = User.get_suggest_user(current_user).first
  end

  def react
    current_user.send(@react.to_sym, @pass_user)
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
