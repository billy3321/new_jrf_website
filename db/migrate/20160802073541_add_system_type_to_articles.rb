class AddSystemTypeToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :system_type, :string
  end
end
