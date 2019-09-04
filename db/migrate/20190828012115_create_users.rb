class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.integer :gender
      t.date :birthday
      t.string :address
      t.string :company
      t.string :image_sc
      t.integer :role, default: 0

      t.timestamps
    end
    add_index :users, :name
    add_index :users, :email
  end
end
