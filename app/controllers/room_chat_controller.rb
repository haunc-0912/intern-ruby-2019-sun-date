class RoomChatController < ApplicationController
  def index
    session[:conversations] ||= []

    @users = User.info_user_match current_user
    @conversations = Conversation.find_current_user current_user
  end
end
