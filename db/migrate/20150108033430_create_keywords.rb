class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :name
      t.references :category, index: true
    end
    add_index :keywords, :name, unique: true
  end
end
