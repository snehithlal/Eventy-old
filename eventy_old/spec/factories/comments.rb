FactoryBot.define do
  factory :comment do
    event_id { 1 }
    user_id { 1 }
    comment { "MyText" }
  end
end
