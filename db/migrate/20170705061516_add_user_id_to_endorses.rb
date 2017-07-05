class AddUserIdToEndorses < ActiveRecord::Migration[5.1]
  def change
    add_column :endorses, :user_id, :integer
  end
end
