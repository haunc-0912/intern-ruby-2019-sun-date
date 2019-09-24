class Message < ApplicationRecord
  enum seen: {not_seen: 0, seen: 1}
  belongs_to :user
  belongs_to :conversation

  after_create_commit { MessageBroadcastJob.perform_later(self) }

  scope :by_conversation, ->(conversation_ids){where conversation_id: conversation_ids}
end
