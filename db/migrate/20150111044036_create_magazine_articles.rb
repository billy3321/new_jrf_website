class CreateMagazineArticles < ActiveRecord::Migration
  def change
    create_table :magazine_articles do |t|
      t.integer :magazine_id
      t.integer :column_id
      t.string :image
      t.string :title
      t.string :author
      t.text :content
      t.text :comment

      t.timestamps null: false
    end
  end
end
