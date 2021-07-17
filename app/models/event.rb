# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'

  has_many :co_hosts, dependent: :destroy
  has_many :user_events, dependent: :destroy
  has_many :recipients, through: :user_events, source: :user

  validate :validate_end_time_after_start_time, if: proc { |event| event.end_time.present? }

  validates :title, presence: true
  validates :description, presence: true
  validates :host_id, presence: true
  validates :start_time, presence: true

  accepts_nested_attributes_for :user_events, allow_destroy: true
  accepts_nested_attributes_for :co_hosts, allow_destroy: true

  private

  def validate_end_time_after_start_time
    errors.add(:end_time, 'cant be before start time') if end_time <= start_time
  end
end
