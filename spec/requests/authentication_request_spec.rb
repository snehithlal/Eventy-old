# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /login' do
    let(:user) { FactoryBot.create(:user, user_name: 'user1', password: 'password') }
    it 'authenticates the user' do
      post '/api/v1/login', params: { user_name: user.user_name, password: 'password' }
      expect(response).to have_http_status(:created)
      expect(json).to eq({ 'user' => { 'id' => user.id, 'user_name' => 'user1' } })
    end
    it 'returns error when user_name does not exist' do
      post '/api/v1/login', params: { user_name: 'user', password: 'password' }
      expect(response).to have_http_status(:not_found)
      expect(json).to eq({ 'error' => 'User not found' })
    end
    it 'returns error when password is incorrect' do
      post '/api/v1/login', params: { user_name: user.user_name, password: 'password1' }
      expect(response).to have_http_status(:unauthorized)
      expect(json).to eq({ 'error' => 'Incorrect username or password' })
    end
  end
end
