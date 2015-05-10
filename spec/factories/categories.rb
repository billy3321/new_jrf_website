FactoryGirl.define do
  factory :category do
    sequence(:name)  { |n| "Category #{n}" }
    catalog { FactoryGirl.create(:catalog) }
    published true
  end
end
