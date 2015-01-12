FactoryGirl.define do
  factory :magazine do
    sequence(:volumn) { |n| "Magazine Volumn #{n}" }
    sequence(:issue) { |n| n }
    sequence(:published_at) { |n| Date.today - n.months }
  end
end