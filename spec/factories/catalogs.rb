FactoryGirl.define do
  factory :catalog do
    sequence(:name) { |n| "Catalog #{n}" }
  end
end