# frozen_string_literal: true

FactoryBot.define do
  factory :co_host do
    association :event, factory: :event
    association :user, factory: :user
  end
end
