# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :user

  has_many :group_users, dependent: :destroy

  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :user_id }
end
