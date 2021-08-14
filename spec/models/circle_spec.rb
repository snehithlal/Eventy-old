# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Circle, type: :model do
  it { should belong_to(:head).class_name('User').with_foreign_key('head_id') }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:head_id) }
end
