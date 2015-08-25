class AddPositionToFaq < ActiveRecord::Migration
  def change
    add_column :faqs, :position, :integer, null: false, default: 0
  end
end
