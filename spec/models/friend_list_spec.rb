# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendList, type: :model do
  # TCs for validations
  it { should belong_to(:requester) }
  it { should belong_to(:acceptor) }
  it { should validate_uniqueness_of(:requester_id).scoped_to(:acceptor_id) }

  # TCs for Creation
  context 'Test cases for creation' do
    let!(:friend1) { create(:user) }
    let!(:friend2) { create(:user) }
    let!(:friend_list) { create(:friend_list, requester_id: friend1.id, acceptor_id: friend2.id) }

    it 'Should not be able to duplicate friendlist both ways' do
      expect { create(:friend_list, requester_id: friend1.id, acceptor_id: friend2.id) }
        .to raise_error(StandardError)
    end

    it 'Should not be able to create friendlist both ways' do
      expect { create(:friend_list, requester_id: friend2.id, acceptor_id: friend1.id) }
        .to raise_error(StandardError, /already friends/)
    end
  end

  # TCs for status changes
  context 'Test cases for status changes' do
    let!(:friend1) { create(:user) }
    let!(:friend2) { create(:user) }
    let!(:friend3) { create(:user) }
    let!(:friend4) { create(:user) }
    let!(:friend5) { create(:user) }
    let!(:friend6) { create(:user) }
    let!(:sent_friend_list) {
      create(:friend_list, requester_id: friend1.id, acceptor_id: friend2.id)
    }
    let!(:accepted_friend_list) {
      create(:friend_list, requester_id: friend3.id, acceptor_id: friend4.id, status: 1)
    }
    let!(:rejected_friend_list) {
      create(:friend_list, requester_id: friend5.id, acceptor_id: friend6.id, status: 2)
    }

    it 'Should be able to change status change from Sent to Accepted' do
      sent_friend_list.status = 1
      expect(sent_friend_list).to be_valid
    end

    it 'Should be able to change status change from Sent to Rejected' do
      sent_friend_list.status = 2
      expect(sent_friend_list).to be_valid
    end

    it 'Should not be able to change status change from Accepted to Rejected' do
      accepted_friend_list.status = 2
      expect(accepted_friend_list).to_not be_valid
    end

    it 'Should not be able to change status change from Accepted to Sent' do
      accepted_friend_list.status = 0
      expect(accepted_friend_list).to_not be_valid
    end

    it 'Should not be able to change status change from Rejected to Sent' do
      rejected_friend_list.status = 0
      expect(rejected_friend_list).to_not be_valid
    end

    it 'Should not be able to change status change from Rejected to Accepted' do
      rejected_friend_list.status = 1
      expect(rejected_friend_list).to_not be_valid
    end
  end
  
  # TCs for retrieving status name
  context 'Retrive humanized status' do
    let!(:friend1) { create(:user) }
    let!(:friend2) { create(:user) }
    let!(:friend3) { create(:user) }
    let!(:friend4) { create(:user) }
    let!(:friend5) { create(:user) }
    let!(:friend6) { create(:user) }
    let!(:sent_friend_list) {
      create(:friend_list, requester_id: friend1.id, acceptor_id: friend2.id)
    }
    let!(:accepted_friend_list) {
      create(:friend_list, requester_id: friend3.id, acceptor_id: friend4.id, status: 1)
    }
    let!(:rejected_friend_list) {
      create(:friend_list, requester_id: friend5.id, acceptor_id: friend6.id, status: 2)
    }
    
    it 'should return alice bob charlie' do
      expect(sent_friend_list.humanize_status).to eq('Sent')
    end
    
    it 'should return alice bob charlie' do
      expect(accepted_friend_list.humanize_status).to eq('Accepted')
    end
    
    it 'should return alice bob charlie' do
      expect(rejected_friend_list.humanize_status).to eq('Rejected')
    end
  end
  
end
