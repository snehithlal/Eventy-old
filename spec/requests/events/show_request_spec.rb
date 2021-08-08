# frozen_string_literal: true

require 'rails_helper'
include EventSpecHelper

RSpec.describe 'Event show', type: :request do
  let!(:events) { create_list(:event_with_recipients, 2) }
  let(:event_id) { events.first.id }
  describe 'get events/:id' do
    before do
      get "/api/v1/events/#{event_id}", headers: valid_headers
    end

    context 'when the record exists' do
      it 'returns event' do
        expect(json).not_to be_empty
        expect(response).to have_http_status(200)
        expect(json['event']['id']).to eq(event_id)
      end
    end
  end
end
