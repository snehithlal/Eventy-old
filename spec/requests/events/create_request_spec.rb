# frozen_string_literal: true

require 'rails_helper'
include EventSpecHelper

RSpec.describe 'Events Create', type: :request do
  describe 'post /create' do
    let(:user) { create(:user) }

    context 'when request is valid' do
      let(:valid_params) { { event: attributes_for(:event, title: 'new_event', host_id: user.id) } }
      let(:valid_params_with_users) do
        {
          event: attributes_for(:event,
                                host_id: user.id,
                                user_events_attributes: makes_user_event_id_hash(2)
                               )
        }
      end
      let(:valid_params_with_co_hosts) do
        {
          event: attributes_for(:event,
                                host_id: user.id,
                                user_events_attributes: makes_user_event_id_hash(2),
                                co_hosts_attributes: makes_user_event_id_hash(2)
                               )
        }
      end

      context 'with event params only' do
        before do
          post '/api/v1/events', params: valid_params.to_json, headers: valid_headers
        end
        it 'should create an event' do
          expect(json['event']['title']).to eq('new_event')
        end

        it 'should return status code' do
          expect(response).to have_http_status(:created)
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

        it 'should create 2 user_events' do
          expect(json['event']['user_events'].length).to eql 2
        end
      end

      context 'should create event with  co hosts' do
        before do
          post '/api/v1/events', params: valid_params_with_co_hosts.to_json, headers: valid_headers
        end

        it 'should return status code' do
          expect(response).to have_http_status(:created)
        end

        it 'should return co_hosts response' do
          expect(json['event']['co_hosts']).to be_present
        end

        it 'should create 2 co_hosts' do
          expect(json['event']['co_hosts'].length).to eql 2
        end
      end
    end
  end
end
