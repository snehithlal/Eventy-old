# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApiController
      before_action :fetch_event, only: [:edit, :show, :update]

      def index
        render_all_events(params)
      end

      def create
        event = Event.new(event_params)
        if event.save
          render json: EventSerializer.render_as_json(event, root: :event, view: :with_all_associations),
                 status: :created
        else
          render json: { errors: event.errors.messages }, status: :unprocessable_entity
        end
      end

      def edit
        render json: EventSerializer.render_as_json(@event, root: :event, view: :with_all_associations),
               status: :ok
      end

      def show
        render json: EventSerializer.render_as_json(@event, root: :event, view: :with_all_associations),
               status: :ok
      end

      def update
        if @event.update(event_params)
          render json: EventSerializer.render_as_json(@event, root: :event, view: :with_all_associations),
                 status: :ok
        else
          render json: { errors: @event.errors.messages },
                 status: :unprocessable_entity
        end
      end

      def toggle_pin
        user_event = UserEvent.find_by(id: params[:id])
        if user_event.present?
          user_event.toggle_priority
          parameters = { id: user_event.id }
          render_all_events(parameters)
        else
          render json: { errors: :user_event_not_found },
                 status: :not_found
        end
      end

      private

      def event_params
        params.require(:event).permit(:title, :description, :start_time, :end_time, :host_id,
          user_events_attributes: [:id, :_destroy, :user_id, :event_role])
      end

      def fetch_event
        @event = Event.find(params[:id])
      end

      def render_all_events(parameters)
        events = EventQuery.call(current_user, parameters)
        render json: EventSerializer.render_as_json(events, root: :event, view: :with_all_associations),
               status: :ok
      end
    end
  end
end
