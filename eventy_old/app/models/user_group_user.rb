class UserGroupUser < ApplicationRecord
  belongs_to :user_group
  belongs_to :user
end
