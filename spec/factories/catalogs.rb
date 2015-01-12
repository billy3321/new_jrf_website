FactoryGirl.define do
  factory :catalog do
    sequence(:catalog)  { |n| "Catalog #{n}" }
  end
end