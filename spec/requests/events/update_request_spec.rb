# frozen_string_literal: true

require 'rails_helper'
include EventSpecHelper

RSpec.describe 'Event Update', type: :request do
  let(:event) { create(:event, title: 'hello') }
  let(:main_event) { create(:event_with_recipients_and_co_hosts, users_count: 2, co_hosts_count: 1) }
  let(:remove_participant) {
    { _destroy: true }.merge(main_event.user_events.participants.first.attributes) }
  let(:remove_co_host) {
    { _destroy: true }.merge(main_event.user_events.co_hosts.first.attributes) }
  let(:add_partcipants) { makes_user_event_id_hash(2) }
  let(:add_co_hosts) { makes_user_event_id_hash(1, 'co_host') }

  describe 'patch /:id' do
    context 'when the record updated with only events' do
      before do
        patch "/api/v1/events/#{main_event.id}",
          params: { title: 'updated' }.to_json,
          headers: valid_headers
      end

      it 'should have the status 200' do
        expect(response).to have_http_status(200)
      end

      it 'should have the title updated' do
        expect(json['event']['title']).to eq('updated')
      end

      it 'should have one admin' do
        expect(fetch_by_event_role(json, 'admin').count).to eql 1
      end

      it 'should have 2 participants' do
        expect(fetch_by_event_role(json, 'participant').count).to eql 2
      end

      it 'should have 1 co_cost' do
        expect(fetch_by_event_role(json, 'co_host').count).to eql 1
      end
    end

    context 'when adding new participants' do
      before do
        patch "/api/v1/events/#{main_event.id}",
          params: { title: 'updated',
          user_events_attributes: add_partcipants
        }.to_json,
          headers: valid_headers
      end

      it 'should add new participants' do
        expect(fetch_by_event_role(json, 'participant').count).to eql 4
      end
    end

    context 'when adding new co hosts' do
      before do
        patch "/api/v1/events/#{main_event.id}",
          params: { title: 'updated',
          user_events_attributes: add_co_hosts
        }.to_json,
          headers: valid_headers
      end

      it 'should add new co host' do
        expect(fetch_by_event_role(json, 'co_host').count).to eql 2
      end
    end

    context 'when removing participants' do
      before do
        patch "/api/v1/events/#{main_event.id}",
          params: { title: 'updated',
          user_events_attributes: [remove_participant] }.to_json,
          headers: valid_headers
      end

      it 'should remove user event when destroy passed' do
        expect(fetch_by_event_role(json, 'participant').count).to eql 1
      end
    end

    context 'when removing co_host' do
      before do
        patch "/api/v1/events/#{main_event.id}",
          params: { title: 'updated',
          user_events_attributes: [remove_co_host] }.to_json,
          headers: valid_headers
      end

      it 'should removeco_host when destroy passed' do
        expect(fetch_by_event_role(json, 'co_host').count).to eql 0
      end
    end
  end
end
