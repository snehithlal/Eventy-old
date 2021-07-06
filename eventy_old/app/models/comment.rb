class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates_presence_of :comment
end
