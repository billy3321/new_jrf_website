class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.references :user, index: true
      t.references :catalog, index: true
      t.references :category, index: true
      t.string :author
      t.date :published_at
      t.string :image
      t.text :description
      t.boolean :published, default: false

      t.timestamps null: false
    end
    #add_foreign_key :articles, :users
    #add_foreign_key :articles, :catalogs
    #add_foreign_key :articles, :categories
  end
end
