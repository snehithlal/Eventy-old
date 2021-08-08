# frozen_string_literal: true

require 'rails_helper'
include EventSpecHelper

RSpec.describe 'Events Create', type: :request do
  describe 'post /create' do
    let(:user) { create(:user, user_name: 'elon') }
    let(:co_host) { create(:user, user_name: 'musk') }

    context 'when request is valid' do
      let(:valid_params) { { event: attributes_for(:event, title: 'new_event', host_id: user.id) } }
      let(:user_event_details) { makes_user_event_id_hash(2) << { user_id: co_host.id, event_role: 'co_host' } }
      let(:valid_params_with_users) do
        {
          event: attributes_for(:event,
                                host_id: user.id,
                                user_events_attributes: user_event_details
                               )
        }
      end
      context 'with event params only' do
        before do
          post '/api/v1/events', params: valid_params.to_json, headers: valid_headers
        end
        it 'should create an event' do
          expect(json.dig('event', 'title')).to eq('new_event')
        end

        it 'should return status code' do
          expect(response).to have_http_status(:created)
        end

        it 'should create one user_event for host' do
          expect(json.dig('event', 'user_events').length).to eql 1
        end

        it 'should have user event with user_id same as host' do
          expect(fetch_by_event_role(json, 'admin').first.dig('user', 'id')).to eql user.id
        end

        it 'should have user event with event_role admin' do
          expect(fetch_by_event_role(json, 'admin').count).to eql 1
        end
      end

      context 'with nested user event params' do
        before do
          post '/api/v1/events', params: valid_params_with_users.to_json, headers: valid_headers
        end

        it 'should return status code' do
          expect(response).to have_http_status(:created)
        end

        it 'should return user_event response' do
          expect(json['event']['user_events']).to be_present
        end

        it 'should create 4 user_events' do
          expect(json['event']['user_events'].length).to eql 4
        end

        it 'should create 2 user_events with event role as participant' do
          expect(fetch_by_event_role(json, 'participant').count).to eql 2
        end

        it 'should have 1 admin user event' do
          expect(fetch_by_event_role(json, 'admin').count).to eql 1
        end

        it 'should have 1 co host user_event' do
          expect(fetch_by_event_role(json, 'co_host').count).to eql 1
        end
      end
    end
  end
end
