class AddSeenAtToConversations < ActiveRecord::Migration[5.2]
  def change
    add_column :conversations, :seen_at, :datetime
  end
end
