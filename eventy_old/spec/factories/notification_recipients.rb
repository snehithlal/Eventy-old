FactoryBot.define do
  factory :notification_recipient do
    notification_id { 1 }
    user_id { 1 }
    is_read { false }
  end
end
