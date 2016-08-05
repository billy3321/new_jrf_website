class AddFbIaContentToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :fb_ia_content, :text
  end
end