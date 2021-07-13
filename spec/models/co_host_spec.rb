# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoHost, type: :model do
  it { should belong_to(:event) }
  it { should belong_to(:user) }
  it { should have_many(:user_events).through(:event) }
  it { should validate_presence_of(:event_id) }
  it { should validate_presence_of(:user_id) }
end
