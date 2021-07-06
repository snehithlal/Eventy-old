require 'rails_helper'

RSpec.describe Event, type: :model do
  
  describe 'associations' do
    it { should belong_to(:host).class_name('User') } 
    it { should have_many(:user_events).dependent(:destroy) } 
    it { should have_many(:comments).dependent(:destroy) } 
  end
  
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

end
