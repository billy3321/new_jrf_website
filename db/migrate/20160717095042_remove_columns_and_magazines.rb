class RemoveColumnsAndMagazines < ActiveRecord::Migration
  def change
    drop_table :columns
    drop_table :magazines
    drop_table :magazine_articles
    drop_table :keywords_magazine_articles
    drop_table :epapers
  end
end
