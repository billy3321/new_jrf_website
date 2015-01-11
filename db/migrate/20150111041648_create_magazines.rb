class CreateMagazines < ActiveRecord::Migration
  def change
    create_table :magazines do |t|
      t.string :name
      t.string :volumn
      t.integer :issue
      t.date :published_at

      t.timestamps null: false
    end
  end
end
