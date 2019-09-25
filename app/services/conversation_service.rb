class ConversationService
  def seen! conversation
    @message = Message.by_conversation conversation.id
    @message.update_all seen: :seen
  end

  def unSeen user_id
    conversation_list = Conversation.by_user user_id
    @newmessage = []
    conversation_list.each do |conversation|
      messages = Message.is_receiver user_id, conversation.id
      messages.each do |message|
        if conversation.seen_at.nil? || (message.created_at > conversation.seen_at)
          @newmessage.append(message)
        end
      end
    end
    return @newmessage
  end
end
