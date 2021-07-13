# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:host).class_name('User').with_foreign_key('host_id') }
  it { should have_many(:co_hosts).dependent(:destroy) }
  it { should have_many(:user_events).dependent(:destroy) }
  it { should have_many(:recipients).through(:user_events).source(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:host_id) }
  it { should validate_presence_of(:start_time) }
end
