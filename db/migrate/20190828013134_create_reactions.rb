class CreateReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :reactions do |t|
      t.integer :active_user_id
      t.integer :passive_user_id
      t.integer :status

      t.timestamps
    end
    add_index :reactions, :active_user_id
    add_index :reactions, :passive_user_id
    add_index :reactions, [:active_user_id, :passive_user_id], unique: true
  end
end
