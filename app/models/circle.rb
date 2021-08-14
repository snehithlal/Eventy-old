# frozen_string_literal: true

class Circle < ApplicationRecord
  belongs_to :head, class_name: 'User', foreign_key: 'head_id'

  before_create :assign_circle_head

  validates :name, presence: true
  validates :description, presence: true
  validates :head_id, presence: true

  private

  def assign_circle_head
    self.head = Current.user
  end
end
