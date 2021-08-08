# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    association :host, factory: :user
    title { Faker::Restaurant.name }
    description {  Faker::Restaurant.description }
    place { Faker::Address.street_name  }
    start_time { Faker::Date.forward(days: 10) }

    factory :event_with_recipients do
      transient do
        users_count { 5 }
      end

      user_events do
        Array.new(users_count) { association(:user_event) }
      end
    end
  end
end
