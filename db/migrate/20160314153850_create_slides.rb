class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.integer :position
      t.integer :slideable_id
      t.string  :slideable_type
      t.string  :image
    end
  end
end
