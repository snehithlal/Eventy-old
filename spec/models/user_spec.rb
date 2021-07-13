# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, first_name: 'alice', middle_name: 'bob', last_name: 'charlie') }

  it { should validate_presence_of(:user_name) }
  it { should validate_uniqueness_of(:user_name) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_length_of(:user_name).is_at_least(3) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:password) }
  it { should have_many(:user_events) }
  it { should have_many(:events).through(:user_events) }

  context 'given full name' do
    it 'should return alice bob charlie' do
      expect(user.full_name).to eq('alice bob charlie')
    end
  end
end
