class AddColumnsToDatingInformations < ActiveRecord::Migration[5.2]
  def change
    add_column :dating_informations, :prefer_gender, :integer
    add_column :dating_informations, :latitude, :decimal, {precision: 10, scale: 6}
    add_column :dating_informations, :longitude, :decimal, {precision: 10, scale: 6}
    add_reference :dating_informations, :user, index: true
  end
end
