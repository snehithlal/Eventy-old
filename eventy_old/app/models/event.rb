class Event < ApplicationRecord
  belongs_to :host, class_name: "User", foreign_key:"host_id"
  has_many :user_events, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates_presence_of :title
  validates_presence_of :description
end