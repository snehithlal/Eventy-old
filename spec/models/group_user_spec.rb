# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupUser, type: :model do
  # Group users validation
  it { should belong_to(:group) }
  it { should validate_presence_of(:group_id) }
  it { should validate_presence_of(:user_id) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:group_id) }

  # Group user creation error
  context 'create group users' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:group1) { create(:group, user_id: user1.id) }
    let!(:group_user1) { create(:group_user, group_id: group1.id, user_id: user2.id) }

    it 'Should not be able to repeat same user for given group' do
      expect { create(:group_user, group_id: group1.id, user_id: user2.id) }
      .to raise_error(StandardError)
    end
  end
end
