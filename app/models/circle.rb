# frozen_string_literal: true

class Circle < ApplicationRecord
  belongs_to :head, class_name: 'User', foreign_key: 'head_id'

  before_create :assign_circle_head

  validates :name, presence: true
  validates :description, presence: true
  validates :head_id, presence: true

  scope :for_member, -> (member_id) { where("'?' = ANY(member_ids)", member_id) }
  scope :for_user, -> (user_id = Current.user&.id) { where(head_id: user_id).or(for_member(user_id)) }

  def members
    @_members ||= User.where(id: member_ids)
  end

  private

  def assign_circle_head
    self.head = Current.user
  end
end
