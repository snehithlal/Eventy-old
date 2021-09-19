# frozen_string_literal: true

class UserEvent < ApplicationRecord
  enum event_role: { participant: 0, admin: 1, co_host: 2 }

  belongs_to :event
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :event_id }
  validates :priority, uniqueness: { scope: :user_id, allow_blank: true }

  scope :admins, -> { where(event_role: 'admin') }
  scope :participants, -> { where(event_role: 'participant') }
  scope :co_hosts, -> { where(event_role: 'co_host') }
  scope :for_user, ->(user_id) { where(user_id: user_id) }
  scope :order_by_priority, -> { order('priority DESC NULLS LAST') }

  before_update :reorder_priorities, if: :reorderable?
  before_destroy :remove_priority, if: :has_priority?

  def has_priority?
    priority.present?
  end

  def toggle_priority
    priority.present? ? remove_priority : add_priority
  end

  def remove_priority
    update(priority: nil)
  end

  def add_priority
    update(priority: last_priority + 1)
  end

  def associated_user_events
    UserEvent.for_user(user_id).where.not(id: id)
  end

  def last_priority
    associated_user_events.order_by_priority.first.try(:priority) || 0
  end

  private

  def reorderable?
    priority_changed? && priority_was.to_i.positive? && last_priority.positive?
  end

  def reorder_priorities
    reorderable_events = associated_user_events.order_by_priority.where(['priority > ?', priority_was.to_i])
    reorderable_events.update_all('priority = priority - 1')
  end
end
