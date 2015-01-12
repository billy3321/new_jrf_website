FactoryGirl.define do
  factory :column do
    sequence(:name) { |n| "Column #{n}" }
  end
end
