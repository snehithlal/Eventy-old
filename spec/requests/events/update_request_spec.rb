# frozen_string_literal: true

require 'rails_helper'
include EventSpecHelper

RSpec.describe 'Event Update', type: :request do
  let(:event) { create(:event, title: 'hello') }
  let(:main_event) { create(:event_with_recipients_and_co_hosts, users_count: 2) }
  let(:remove_user_event_attr) { { _destroy: true }.merge(main_event.user_events.first.attributes) }
  let(:remove_co_host_attr) { { _destroy: true }.merge(main_event.co_hosts.last.attributes) }
  let(:add_user_events) { makes_user_event_id_hash(2) }
  let(:add_co_hosts) { makes_user_event_id_hash(1) }
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
    end

    context 'when adding new user_events or co hosts' do
      before do
        patch "/api/v1/events/#{main_event.id}",
          params: { title: 'updated',
          user_events_attributes: add_user_events,
          co_hosts_attributes: add_co_hosts
        }.to_json,
          headers: valid_headers
      end

      it 'should add new user events' do
        expect(main_event.user_events.count).to eql(4)
      end

      it 'should add new co host' do
        expect(main_event.co_hosts.count).to eql(3)
      end
    end

    context 'when removing user_events and co hosts' do
      before do
        patch "/api/v1/events/#{main_event.id}",
          params: { title: 'updated',
          user_events_attributes: [remove_user_event_attr],
          co_hosts_attributes: [remove_co_host_attr] }.to_json,
          headers: valid_headers
      end

      it 'should remove user event when destroy passed' do
        expect(main_event.user_events.count).to eql(1)
      end

      it 'should remove co host when destroy passed' do
        expect(main_event.co_hosts.count).to eql(1)
      end
    end
  end
end
