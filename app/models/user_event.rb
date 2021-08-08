# frozen_string_literal: true

class UserEvent < ApplicationRecord
  enum event_role: { participant: 0, admin: 1, co_host: 2 }

  belongs_to :event
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :event_id }

  scope :admins, -> { where(event_role: 'admin') }
  scope :participants, -> { where(event_role: 'participant') }
  scope :co_hosts, -> { where(event_role: 'co_host') }

  # call using participant? or admin?
  %w(participant admin co_host).each do |method_name|
    define_method "#{method_name}?" do
      event_role == method_name
    end
  end
end
