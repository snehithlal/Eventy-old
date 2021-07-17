# frozen_string_literal: true

class EventSerializer < Blueprinter::Base
  identifier :id

  fields :description, :title, :comment_enabled, :quick_event,
         :place, :start_time, :end_time, :completed

  association :user_events, blueprint: UserEventSerializer
  association :co_hosts, blueprint: CoHostSerializer

  view :extended do
    fields :review
  end
end
