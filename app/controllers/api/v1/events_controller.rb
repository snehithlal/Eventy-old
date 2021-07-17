# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApiController
      def create
        event = Event.new(event_params)
        if event.save
          render json: EventSerializer.render_as_json(event, root: :event, view: :with_all_associations),
                        status: :created
        else
          render json: { errors: event.errors.messages }, status: :unprocessable_entity
        end
      end

      private

      def event_params
        params.require(:event).permit(:title, :description, :start_time, :end_time, :host_id,
          user_events_attributes: [:user_id], co_hosts_attributes: [:user_id])
      end
    end
  end
end
