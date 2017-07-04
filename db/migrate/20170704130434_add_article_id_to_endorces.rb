class AddArticleIdToEndorces < ActiveRecord::Migration[5.1]
  def change
    add_column :endorses, :article_id, :integer
  end
end
