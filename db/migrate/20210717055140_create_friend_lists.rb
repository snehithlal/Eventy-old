# frozen_string_literal: true

class CreateFriendLists < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_lists do |t|
      t.integer :requester_id
      t.integer :acceptor_id
      t.integer :status, limit: 1, default: 0
      t.timestamps
    end
  end
end
