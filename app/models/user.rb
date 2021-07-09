# frozen_string_literal: true

class User < ApplicationRecord
  validates :user_name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true

  has_secure_password
  has_one_attached :avatar

  def full_name
    "#{first_name} #{middle_name} #{last_name}".squish
  end
end
