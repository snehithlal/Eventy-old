# frozen_string_literal: true

class CoHost < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :user_events, through: :event

  validates :event_id, presence: true
  validates :user_id, presence: true
end
