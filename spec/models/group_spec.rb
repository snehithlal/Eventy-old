# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  # Group validations
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }
  it { should validate_uniqueness_of(:name).scoped_to(:user_id) }

  # Group creation error
  context 'create group' do
    let!(:user1) { create(:user) }
    let!(:group1) { create(:group, user_id: user1.id) }

    it 'Should not be able to repeat same group name for given user' do
      expect { create(:group, name: group1.name, user_id: user1.id) }
      .to raise_error(StandardError)
    end
  end
end
