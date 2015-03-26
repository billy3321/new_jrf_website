class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :name
      t.references :category, index: true
      t.boolean :showed, default: false
      t.boolean :published, default: true
      t.string :image
      t.string :cover
      t.string :title
      t.text :description
    end
    add_index :keywords, :name, unique: true
  end
end
