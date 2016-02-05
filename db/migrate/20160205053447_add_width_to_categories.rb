class AddWidthToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :width, :integer, null: false, default: 1
  end
end
