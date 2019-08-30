class CreateDatingInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :dating_informations do |t|
      t.integer :height
      t.integer :weight
      t.string :dating_location
      t.integer :dating_distance
      t.integer :start_age
      t.integer :end_age
      t.text :description
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
