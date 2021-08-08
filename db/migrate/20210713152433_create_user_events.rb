# frozen_string_literal: true

class CreateUserEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :user_events do |t|
      t.integer :event_id, index: true
      t.integer :user_id
      t.integer :priority
      t.integer :event_role, default: 0, index: true
      t.datetime :reminder_time
      t.boolean :reminder_enabled, default: true

      t.timestamps
      t.index [:user_id, :priority]
    end
  end
end
