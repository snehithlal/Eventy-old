require 'rails_helper'

RSpec.describe UserGroupUser, type: :model do
  
  describe 'associations' do
    it { should belong_to(:user_group) } 
    it { should belong_to(:user) } 
  end
end
