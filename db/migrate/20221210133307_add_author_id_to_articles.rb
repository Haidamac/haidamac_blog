class AddAuthorIdToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :author_id, :bigint
  end
end
