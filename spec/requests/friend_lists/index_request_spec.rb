# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FriendLists Index', type: :request do
  describe 'GET /index' do
    let!(:user) { create(:user) }
    let!(:friend1) { create(:user) }
    let!(:friend2) { create(:user) }

    context 'no friends connected yet' do
      it 'should get not friends user record' do
        get '/api/v1/friend_lists', headers: valid_headers(user)
        expect(response).to have_http_status(200)
        users = JSON.parse(response.body)['user']
        expect(users).to be_empty
      end
    end

    context 'connected friends exists' do
      let(:friend_list1) { create(:friend_list, requester_id: user.id, acceptor_id: friend1.id) }
      let(:friend_list2) { create(:friend_list, requester_id: friend2.id, acceptor_id: user.id) }
      let(:actual_friends) { User.where(id: [friend1.id, friend2.id]).pluck(:id) }

      it 'should get all connected friends user record' do
        friend_list1.update(status: 1)
        friend_list2.update(status: 1)
        get '/api/v1/friend_lists', headers: valid_headers(user)
        expect(response).to have_http_status(200)
        users = JSON.parse(response.body)['user']
        user_ids = users.collect { |x| x['id'] }
        expect(user_ids).to match_array(actual_friends)
        expect(users).not_to be_empty
      end
    end

    context 'friend request sent but no friends connected yet' do
      let(:friend_list1) { create(:friend_list, requester_id: user.id, acceptor_id: friend1.id) }
      let(:friend_list2) { create(:friend_list, requester_id: friend2.id, acceptor_id: user.id) }
      let(:actual_friends) { user.friends_list.pluck(:id) }

      it 'should get not friends user record' do
        get '/api/v1/friend_lists', headers: valid_headers(user)
        users = JSON.parse(response.body)['user']
        user_ids = users.collect { |x| x['id'] }
        expect(users).to match_array(actual_friends)
        expect(user_ids).to be_empty
      end
    end
  end
end
