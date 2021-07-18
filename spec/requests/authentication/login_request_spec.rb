# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /login' do
    let(:user) { create(:user, user_name: 'user1', password: 'password') }
    let(:headers) { valid_headers(user).except('Authorization') }
    let(:valid_credentials) do
      { user_name: user.user_name, password: 'password' }.to_json
    end

    it 'authenticates the user' do
      post '/api/v1/login', params: { user_name: user.user_name, password: 'password' }
      expect(response).to have_http_status(:created)
      expect(auth_response_without_token).to eq({ 'id' => user.id, 'user_name' => 'user1' })
    end

    it 'returns error when user_name does not exist' do
      post '/api/v1/login', params: { user_name: 'user', password: 'password' }
      expect(response).to have_http_status(:not_found)
      expect(json).to eq({ 'error' => 'user_not_found' })
    end

    it 'returns error when password is incorrect' do
      post '/api/v1/login', params: { user_name: user.user_name, password: 'password1' }
      expect(response).to have_http_status(:unauthorized)
      expect(json).to eq({ 'error' => 'incorrect_username_or_password' })
    end

    context 'when request is valid' do
      before { post '/api/v1/login', params: valid_credentials, headers: headers }

      it 'returns an authentication token' do
        expect(auth_response_without_token).not_to be_nil
      end
    end
  end
end
