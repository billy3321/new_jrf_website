class CreateJoinTableArticleKeyword < ActiveRecord::Migration
  def change
    create_join_table :articles, :keywords do |t|
      # t.index [:article_id, :keyword_id]
      # t.index [:keyword_id, :article_id]
    end
  end
end
