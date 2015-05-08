class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :author
      t.string :kind
      t.date :published_at
      t.string :image
      t.text :description
      t.boolean :published, default: false

      t.timestamps null: false
    end
  end
end
