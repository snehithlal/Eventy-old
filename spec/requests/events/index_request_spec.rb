# frozen_string_literal: true

require 'rails_helper'
include EventSpecHelper

RSpec.describe 'Events index', type: :request do
  describe 'get /' do
    let(:user) { create(:user) }
    let!(:host_events) { create_list(:event_with_recipients, 3, host: user) }
    let!(:events) { create_list(:event_with_recipients, 3) }

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
  end
end
