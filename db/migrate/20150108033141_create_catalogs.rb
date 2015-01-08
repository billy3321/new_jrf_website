class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.string :name

      t.timestamps null: false
    end

    add_index :catalogs, :name, unique: true
  end
end
