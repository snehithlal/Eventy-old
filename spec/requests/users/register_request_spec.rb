# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /register' do
    context 'register a new user' do
      before do
        post '/api/v1/register', params: {
          user: attributes_for(:user, user_name: 'user1')
        }
      end

      it 'should register a new user' do
        expect(response).to have_http_status(:created)
      end

      it 'should have the expected response' do
        expect(auth_response_without_token).to eq({ 'id' => User.last.id, 'user_name' => 'user1' })
      end
    end
  end
end
