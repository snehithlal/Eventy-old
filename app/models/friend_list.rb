# frozen_string_literal: true

class FriendList < ApplicationRecord
  STATUS = { 0 => 'Sent', 1 => 'Accepted', 2 => 'Rejected', 3 => 'Blocked' }

  validates_uniqueness_of :requester_id, scope: :acceptor_id
  validates :status, numericality: { only_integer: true }
  validates :status, format: { with: /0/, message: 'is invalid' }, on: :create
  validate :validate_reverse_friend_list
  validate :status_changes, if: :status_changed?, on: :update

  belongs_to :requester, class_name: 'User', foreign_key: :requester_id
  belongs_to :acceptor, class_name: 'User', foreign_key: :acceptor_id

  scope :accepted, -> { where(status: 1) }

  # Return readable form of status
  def humanize_status
    STATUS[status]
  end

  private

  # Validate if the friend list record in duplicate in reverse
  def validate_reverse_friend_list
    if FriendList.exists?(requester_id: acceptor_id, acceptor_id: requester_id)
      errors.add(:base, 'already friends')
    end
  end

  # Validate status change updates
  def status_changes
    unless status_was == 0 && status == 1
      errors.add(:status, 'invalid status change')
    end
  end
end
