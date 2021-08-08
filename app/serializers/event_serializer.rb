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


  view :with_all_associations do
    include_views :with_user_events
  end
end
