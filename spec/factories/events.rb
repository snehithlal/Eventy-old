# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    association :host, factory: :user
    title { Faker::Restaurant.name }
    description { Faker::Restaurant.description }
    place { Faker::Address.street_name  }
    start_time { Faker::Date.forward(days: Faker::Number.within(range: 1..10)) }

    factory :event_with_recipients do
      transient do
        users_count { 5 }
      end

      user_events do
        Array.new(users_count) { association(:user_event) }
      end
    end

    factory :event_with_recipients_and_co_hosts do
      transient do
        users_count { 5 }
        co_hosts_count { 2 }
      end

      user_events do
        user_events = Array.new(users_count) { association(:user_event) }
        co_host_events = Array.new(co_hosts_count) { association(:user_event, event_role: 'co_host') }
        user_events + co_host_events
      end
    end
  end
end
