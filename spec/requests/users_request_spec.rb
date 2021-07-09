# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /register' do
    it 'registers a new user' do
      post '/api/v1/register', params: { user: {
        user_name: 'user1',
        email: 'admin@admin.com',
        password: 'password',
        first_name: 'John',
        last_name: 'Doe'
      } }
      expect(response).to have_http_status(:created)
      expect(json).to eq({ 'user' => { 'id' => User.last.id, 'user_name' => 'user1' } })
    end
  end
end
