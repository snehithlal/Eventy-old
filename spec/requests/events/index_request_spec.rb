# frozen_string_literal: true

require 'rails_helper'
include EventSpecHelper

RSpec.describe 'Events index and toggle priority', type: :request do
  describe 'get /' do
    let(:user) { create(:user) }
    let!(:host_events) { create_list(:event_with_recipients, 3, host: user) }
    let!(:events) { create_list(:event_with_recipients, 3) }
    let(:user_event) { create(:user_event) }

    describe 'get events/' do
      before do
        get '/api/v1/events', headers: valid_headers, params: {}
      end

      context 'when the record exists' do
        it 'returns events' do
          expect(json).not_to be_empty
          expect(response).to have_http_status(200)
        end
      end
    end

    describe 'get events/:id/toggle_pin' do
      before do
        get "/api/v1/events/#{user_event.id}/toggle_pin", headers: valid_headers
      end

      context 'when the record toggles' do
        it 'returns event' do
          expect(json).not_to be_empty
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end
