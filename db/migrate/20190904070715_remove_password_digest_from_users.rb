class RemovePasswordDigestFromUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.remove :password_digest
    end
  end
end
