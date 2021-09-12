# frozen_string_literal: true

FactoryBot.define do
  factory :user_event do
    association :event, factory: :event
    association :user, factory: :user
    reminder_time { Faker::Date.forward(days: 10) }
    priority { Faker::Number.within(range: 1..100) }
  end
end
