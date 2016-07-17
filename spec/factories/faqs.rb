FactoryGirl.define do
  factory :faq do
    keyword { FactoryGirl.create(:keyword) }
    sequence(:question) { |n| "Faq question #{n}" }
    sequence(:answer) { |n| "Faq answer #{n}" }
  end
end
