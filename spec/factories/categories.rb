FactoryGirl.define do
  factory :category do
    sequence(:category)  { |n| "Category #{n}" }
  end
end
