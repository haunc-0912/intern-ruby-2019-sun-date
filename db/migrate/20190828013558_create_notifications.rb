class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :content
      t.integer :owner_id
      t.integer :trackable_id
      t.integer :recipient_id
      t.string :trackable_type

      t.timestamps
    end
    add_index :notifications, :owner_id
    add_index :notifications, :recipient_id
    add_index :notifications, [:owner_id, :recipient_id]
  end
end
