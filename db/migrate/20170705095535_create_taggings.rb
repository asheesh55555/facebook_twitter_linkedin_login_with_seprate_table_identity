class CreateTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :taggings do |t|
      t.integer :user_id
      t.integer :article_id

      t.timestamps
    end
  end
end
