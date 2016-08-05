class AddLabelToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :label, :string
    add_column :keywords, :label_type, :string
  end
end
