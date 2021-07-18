# frozen_string_literal: true

FactoryBot.define do
  factory :group_user do
    association :group
    association :user
    group_id { Faker::Number.non_zero_digit }
    user_id { Faker::Number.non_zero_digit }
  end
end
