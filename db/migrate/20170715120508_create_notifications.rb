class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :actor_id
      t.integer :article_id
      t.string :notifiable_for

      t.timestamps
    end
  end
end
