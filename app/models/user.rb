# frozen_string_literal: true

class User < ApplicationRecord
  has_many :events, foreign_key: 'host_id'
  has_many :user_events

  validates :user_name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true

  has_secure_password
  has_one_attached :avatar
  has_many :requested_friends, class_name: 'FriendList', foreign_key: :requester_id
  has_many :accepted_friends, class_name: 'FriendList', foreign_key: :acceptor_id

  def full_name
    "#{first_name} #{middle_name} #{last_name}".squish
  end

  def friends_list
    User.where(id: (requested_friends.accepted.pluck(:acceptor_id) + accepted_friends.accepted.pluck(:requester_id)))
        .order('first_name, last_name')
  end
end
