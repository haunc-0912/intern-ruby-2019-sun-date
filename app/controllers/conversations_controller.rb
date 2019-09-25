class ConversationsController < ApplicationController
  before_action :load_conversations, :add_to_conversations, only: %i(create)

  def create
    conversationService = ConversationService.new
    @conversation.update_attribute :seen_at, params[:seen_time]
    conversationService.seen! @conversation
    respond_to :js
  end

  def close
    @conversation = Conversation.find_by params[:id]
    session[:conversations].delete @conversation.id
    respond_to :js
  end

  private

  def load_conversations
    @conversation = Conversation.get(current_user.id, params[:user_id])
  end

  def add_to_conversations
    return if conversated?
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include? @conversation.id
  end
end
