class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.references :keyword, index: true
      t.string :question
      t.text :answer
    end
  end
end
