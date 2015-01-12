FactoryGirl.define do
  factory :column do
    sequence(:column)  { |n| "Column #{n}" }
  end
end
