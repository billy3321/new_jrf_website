class AddShowPositionToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :show_position, :integer, null: false, default: 0
  end
end
