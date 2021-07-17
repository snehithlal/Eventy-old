# frozen_string_literal: true

FactoryBot.define do
  factory :friend_list do
    requester_id { Faker::Number.non_zero_digit }
    acceptor_id  { Faker::Number.non_zero_digit }
    status { 'Sent' }
  end
end
