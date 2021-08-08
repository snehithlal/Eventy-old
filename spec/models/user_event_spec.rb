# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserEvent, type: :model do
  it { should belong_to(:event) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:event_id) }

  context 'validate scopes' do
    let(:main_event) { create(:event_with_recipients_and_co_hosts, users_count: 2, co_hosts_count: 1) }

    it 'should return partcipants when participants called' do
      expect(main_event.user_events.participants.count).to eql 2
    end

    it 'should return admins when admins called' do
      expect(main_event.user_events.admins.count).to eql 1
    end

    it 'should return co_hosts when co_hosts called' do
      expect(main_event.user_events.co_hosts.count).to eql 1
    end
  end


  context 'validate event role instance methods' do
    let(:admin_event) { create(:user_event, event_role: 'admin') }

    it 'should return true when admin_event.admin?' do
      expect(admin_event.admin?).to be_truthy
    end

    it 'should return fase when admin_event.participant?' do
      expect(admin_event.participant?).to be_falsey
    end
  end

  context 'a context' do
    let(:user) { create(:user, user_name: 'duplicate') }
    let(:duplicate_test) { makes_user_event_id_hash(2) << { user_id: user.id, event_role: 'admin' } }
    let(:event_atttributes) { attributes_for(:event).merge(host_id: user.id, user_events_attributes: duplicate_test) }
    it 'should not store duplicates' do
      events = Event.new(event_atttributes)
      events.save
      expect(events.user_events.admins.count).to eql 1
    end
  end
end
