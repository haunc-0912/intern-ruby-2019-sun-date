class AddStatusToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :status, :integer, default: 0
  end
end
