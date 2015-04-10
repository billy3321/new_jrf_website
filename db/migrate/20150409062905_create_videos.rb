class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :content
      t.references :user, index: true
      t.string :author
      t.string :youtube_url
      t.string :youtube_id
      t.string :image
      t.date :published_at
      t.boolean :published, default: false

      t.timestamps null: false
    end
  end
end
