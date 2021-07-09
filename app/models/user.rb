# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :user_name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true

  def full_name
    "#{first_name} #{middle_name} #{last_name}".squish
  end
end
