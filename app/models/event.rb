# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  has_many :co_hosts, dependent: :destroy
  has_many :user_events, dependent: :destroy
  has_many :recipients, through: :user_events, source: :user

  validates :title, presence: true
  validates :description, presence: true
  validates :host_id, presence: true
  validates :start_time, presence: true
end
