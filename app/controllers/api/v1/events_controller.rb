# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApiController
      before_action :fetch_event, only: [:edit, :show, :update]

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
          render json: { errors: @event.errors.full_messages },
          status: :unprocessable_entity
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
    end
  end
end
