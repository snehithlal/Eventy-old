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
  it { should have_many(:requested_friends) }
  it { should have_many(:accepted_friends) }

  context 'given full name' do
    it 'should return alice bob charlie' do
      expect(user.full_name).to eq('alice bob charlie')
    end
  end

  context 'retrieving friends list' do
    let(:friend) { create(:user) }
    let(:not_friend) { create(:user) }
    let!(:accepted_friend) {
      create(:friend_list, requester_id: user.id, acceptor_id: friend.id, status: 'Accepted')
    }
    let!(:sent_friend) {
      create(:friend_list, requester_id: user.id, acceptor_id: not_friend.id, status: 'Sent')
    }

    it 'should only return friends with with accepted as status' do
      friends_user_ids = user.friends_list.pluck(:id)
      expect(friends_user_ids).to eq([friend.id])
      expect(friends_user_ids).not_to include(not_friend.id)
    end
  end
end
