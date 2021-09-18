# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:host).class_name('User').with_foreign_key('host_id') }
  it { should have_many(:user_events).dependent(:delete_all) }
  it { should have_many(:recipients).through(:user_events).source(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:host_id) }
  it { should validate_presence_of(:start_time) }

  context 'event time validations' do
    let(:event) { create(:event) }
    it 'validate that start time before end_time' do
      event.end_time = Date.today
      expect(event).to_not be_valid
    end
  end
end
