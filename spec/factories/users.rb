FactoryBot.define do
  factory :user do
    user_name { Faker::Name.name }
    email { 'admin@example.com' }
    password { 'admin@123' }
  end
end
