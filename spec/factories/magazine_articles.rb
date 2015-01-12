FactoryGirl.define do
  factory :magazine_article do
    sequence(:title)  { |n| "Article #{n}" }
    sequence(:content)  { |n| "Article Content #{n}" }
    sequence(:author)  { |n| "Author #{n}" }
    sequence(:comment)  { |n| "Article Comment #{n}" }
    magazine {FactoryGirl.create(:magazine)}
    column {FactoryGirl.create(:column)}
    keywords { [ FactoryGirl.create(:keyword) ] }
  end
end
