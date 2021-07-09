require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:user_name) }
  it { should validate_uniqueness_of(:user_name) }
  it { should validate_length_of(:user_name).is_at_least(3) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:password) }
end
