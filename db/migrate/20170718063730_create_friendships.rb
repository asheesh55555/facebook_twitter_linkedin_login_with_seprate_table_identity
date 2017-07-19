class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :sender
      t.integer :receiver
      t.boolean :accept

      t.timestamps
    end
    add_index :friendships, :sender
    add_index :friendships, :receiver
    add_index :friendships, [:sender, :receiver], unique: true
  end
end
