class Notification < ApplicationRecord
  belongs_to :event
  
  validates_presence_of :content
end
