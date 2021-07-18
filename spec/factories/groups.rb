# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    association :user
    name { Faker::Team.name }
    user_id { Faker::Number.non_zero_digit }
  end
end
