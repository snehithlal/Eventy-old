# frozen_string_literal: true

class Event < CircleScopedRecord
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'

  has_many :user_events, dependent: :delete_all
  has_many :recipients, through: :user_events, source: :user

  before_create :add_host_to_the_user_events

  validate :validate_end_time_after_start_time, if: proc { |event| event.end_time.present? }

  validates :title, presence: true
  validates :description, presence: true
  validates :host_id, presence: true
  validates :start_time, presence: true

  # FIXME: check uniqueness with scope in nested params
  accepts_nested_attributes_for :user_events, allow_destroy: true

  scope :for_user, lambda { |user_id| joins(:user_events).where(user_events: { user_id: user_id }) }
  scope :active, -> { where('start_time >= ?', Date.today) }
  scope :order_by_user_priority, ->(user_id) { joins(:user_events)
                                        .where(user_events: { user_id: user_id })
                                        .order('priority ASC NULLS LAST, start_time ASC') }

  private

  def validate_end_time_after_start_time
    errors.add(:end_time, 'cant be before start time') if end_time <= start_time
  end

  def add_host_to_the_user_events
    user_events.build(user_id: host_id, event_role: 'admin')
  end
end
