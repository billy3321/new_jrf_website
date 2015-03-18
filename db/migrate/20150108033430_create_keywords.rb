class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :name
      t.references :category, index: true
      t.boolean :show, default: false
      t.string :image
      t.string :title
      t.text :description
    end
    add_index :keywords, :name, unique: true
  end
end
