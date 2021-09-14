# frozen_string_literal: true

class EventQuery < BaseService
  def initialize(params, user)
    @params = params
    @user = user
  end

  def call
    all_events
    filter_events
    events
  end

  private

  attr_reader :user, :params
  attr_accessor :events

  def all_events
    @events = Event.for_user(user)
  end

  def filter_events
    @events = events.active
    @events = events.order_by_priority
  end
end
