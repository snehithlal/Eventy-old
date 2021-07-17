# frozen_string_literal: true

class CreateFriendLists < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_lists do |t|
      t.integer :requester_id
      t.integer :acceptor_id
      t.string :status, default: 'Sent'
      t.timestamps
    end
  end
end
