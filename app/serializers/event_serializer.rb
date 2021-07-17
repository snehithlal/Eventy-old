# frozen_string_literal: true

class EventSerializer < Blueprinter::Base
  identifier :id

  fields :description, :title, :chat_enabled, :quick_event,
         :place, :start_time, :end_time, :completed


  view :extended do
    fields :review
  end

  view :with_user_events do
    association :user_events, blueprint: UserEventSerializer
  end

  view :with_co_hosts do
    association :co_hosts, blueprint: CoHostSerializer
  end

  view :with_all_associations do
    include_views :with_co_hosts, :with_user_events
  end
end
