class CreateKinds < ActiveRecord::Migration
  def change
    create_table :kinds do |t|
      t.string :name
      t.string :en_name
      t.references :category, index: true
      t.boolean :showed, default: false
      t.boolean :published, default: true
      t.string :image
      t.string :cover
      t.string :title
      t.text :description
      t.text :content
    end
  end
end
