class ConversationService
  def initialize conversation
    @conversation = conversation
  end

  def seen!
    @message = Message.by_conversation @conversation.id
    @message.update_all seen: :seen
  end
end
