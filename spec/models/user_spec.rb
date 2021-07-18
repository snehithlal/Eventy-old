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
  it { should have_many(:events).with_foreign_key('host_id') }
  it { should have_many(:user_events) }
  it { should have_many(:requested_friends).
    class_name('FriendList').
    with_foreign_key(:requester_id)
  }
  it { should have_many(:accepted_friends).
    class_name('FriendList').
    with_foreign_key(:acceptor_id)
  }

  context 'given full name' do
    it 'should return alice bob charlie' do
      expect(user.full_name).to eq('alice bob charlie')
    end
  end

  describe 'retrieving friends list (friends_list method)' do
    let!(:friend1) { create(:user) }
    let!(:friend2) { create(:user) }
    let(:friends) { user.friends_list.pluck(:id) }

    context 'no friends connected yet' do
      it 'should get not friends user record' do
        expect(friends).to be_empty
      end
    end

    context 'friend request sent but no friends connected yet' do
      let!(:friend_list1) { create(:friend_list, requester_id: user.id, acceptor_id: friend1.id) }
      let!(:friend_list2) { create(:friend_list, requester_id: friend2.id, acceptor_id: user.id) }

      it 'should get not friends user record' do
        expect(friends).to be_empty
      end
    end

    context 'connected friends exists' do
      let!(:friend_list1) {
        ft = create(:friend_list, requester_id: user.id, acceptor_id: friend1.id)
        ft.update_attribute(:status, 1)
        ft
      }
      let!(:friend_list2) {
        ft = create(:friend_list, requester_id: friend2.id, acceptor_id: user.id)
        ft.update_attribute(:status, 1)
        ft
      }

      it 'should get all connected friends user record' do
        expect(friends).to match_array([friend1.id, friend2.id])
        expect(friends).not_to be_empty
      end
    end

    context 'two friend request by user but only one accepted connected friends exists' do
      let!(:friend_list1) { create(:friend_list, requester_id: user.id, acceptor_id: friend1.id) }
      let!(:friend_list2) {
        ft = create(:friend_list, requester_id: user.id, acceptor_id: friend2.id)
        ft.update_attribute(:status, 1)
        ft
      }

      it 'should get only accepted friends user record' do
        expect(friends).to match_array([friend2.id])
        expect(friends).not_to be_empty
        expect(friends).not_to match_array([friend1.id])
      end
    end

    context 'two friend request by friend but only one accepted connected friends exists' do
      let!(:friend_list1) { create(:friend_list, requester_id: friend1.id, acceptor_id: user.id, status: 0) }
      let!(:friend_list2) {
        ft = create(:friend_list, requester_id: friend2.id, acceptor_id: user.id)
        ft.update_attribute(:status, 1)
        ft
      }

      it 'should get only accepted friends user record' do
        expect(friends).to match_array([friend2.id])
        expect(friends).not_to be_empty
        expect(friends).not_to match_array([friend1.id])
      end
    end
  end
end
