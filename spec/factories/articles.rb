FactoryGirl.define do
  factory :article do
    title "MyString"
content "MyText"
user nil
catalog nil
category nil
keyword nil
author "MyString"
published_at "2015-01-08"
image "MyString"
description "MyText"
  end

end



FactoryGirl.define do
  factory :article do
    sequence(:title)  { |n| "Article #{n}" }
    sequence(:content)  { |n| "Article Content #{n}" }
    sequence(:author)  { |n| "Author #{n}" }
    sequence(:published_at) { Date.today }
    sequence(:image) { "http://www.online-image-editor.com//styles/2014/images/example_image.png" }
    sequence(:description) { |n| "Article Description #{n}" }
    category { FactoryGirl.create(:category) }
    catalog { FactoryGirl.create(:catalog) }
    user { FactoryGirl.create(:user) }
    keywords [{ FactoryGirl.create(:keyword) }]
  end
end