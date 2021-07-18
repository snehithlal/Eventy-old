# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendList, type: :model do
  # TCs for validations
  it { should belong_to(:requester) }
  it { should belong_to(:acceptor) }
  it { should validate_uniqueness_of(:requester_id).scoped_to(:acceptor_id) }
  it { should validate_numericality_of(:status).only_integer }

  # TCs for Creation
  context 'test cases for creation' do
    let(:friend1) { create(:user) }
    let(:friend2) { create(:user) }
    let(:friend3) { create(:user) }
    let!(:friend_list) { create(:friend_list, requester_id: friend1.id, acceptor_id: friend2.id) }

    it 'should not be able to duplicate friendlist both ways' do
      expect { create(:friend_list, requester_id: friend1.id, acceptor_id: friend2.id) }.
        to raise_error(StandardError)
    end

    it 'should not be able to create friendlist both ways' do
      expect { create(:friend_list, requester_id: friend2.id, acceptor_id: friend1.id) }.
        to raise_error(StandardError, /already friends/)
    end

    it { should allow_value(0).for(:status).on(:create) }

    it { should_not allow_value(1).for(:status).on(:create) }

    it { should_not allow_value(2).for(:status).on(:create) }

    it { should_not allow_value('a').for(:status).on(:create) }
  end

  # TCs for status changes
  context 'test cases for status changes' do
    let(:friend1) { create(:user) }
    let(:friend2) { create(:user) }
    let(:sent_friend_list) { create(:friend_list, requester_id: friend1.id, acceptor_id: friend2.id) }
    let(:accepted_friend_list) {
      ft = create(:friend_list, requester_id: friend1.id, acceptor_id: friend2.id)
      ft.update_attribute(:status, 1)
      ft
    }
    let(:rejected_friend_list) {
      ft = create(:friend_list, requester_id: friend1.id, acceptor_id: friend2.id)
      ft.update_attribute(:status, 2)
      ft
    }

    it 'should be able to change status change from sent to accepted' do
      sent_friend_list.status = 1
      expect(sent_friend_list).to be_valid
    end

    it 'should be able to change status change from sent to rejected' do
      sent_friend_list.status = 2
      expect(sent_friend_list).to_not be_valid
    end

    it 'should not be able to change status change from accepted to rejected' do
      accepted_friend_list.status = 2
      expect(accepted_friend_list).to_not be_valid
    end

    it 'should not be able to change status change from accepted to sent' do
      accepted_friend_list.status = 0
      expect(accepted_friend_list).to_not be_valid
    end

    it 'should not be able to change status change from rejected to sent' do
      rejected_friend_list.status = 0
      expect(rejected_friend_list).to_not be_valid
    end

    it 'should not be able to change status change from rejected to accepted' do
      rejected_friend_list.status = 1
      expect(rejected_friend_list).to_not be_valid
    end
  end

  # TCs for retrieving status name
  context 'retrive humanized status' do
    let(:friend1) { create(:user) }
    let(:friend2) { create(:user) }
    let(:sent_friend_list) {
      create(:friend_list, requester_id: friend1.id, acceptor_id: friend2.id)
    }

    it 'should return humanized status' do
      expect(sent_friend_list.humanize_status).to eq('Sent')
    end

    it 'should return humanized status' do
      sent_friend_list.update(status: 1)
      expect(sent_friend_list.humanize_status).to eq('Accepted')
    end

    it 'should return humanized status' do
      sent_friend_list.update(status: 2)
      expect(sent_friend_list.humanize_status).to eq('Rejected')
    end
  end
end
