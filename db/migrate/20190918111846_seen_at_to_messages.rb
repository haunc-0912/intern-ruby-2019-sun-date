class SeenAtToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :seen, :integer, default: 0
  end
end
