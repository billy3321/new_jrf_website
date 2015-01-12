FactoryGirl.define do
  factory :keyword do
    sequence(:keyword)  { |n| "Keyword #{n}" }
  end
end