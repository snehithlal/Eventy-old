# frozen_string_literal: true

class EventQuery < BaseService
  def initialize(params, user = Current.user)
    @user = user
    @params = params
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
    @events = Event.order_by_user_priority(user)
  end

  def filter_events
    @events = events.active
  end
end
