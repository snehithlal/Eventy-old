# frozen_string_literal: true

class CreateUserEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :user_events do |t|
      t.integer :event_id
      t.integer :user_id
      t.integer :priority
      t.datetime :reminder_time
      t.boolean :reminder_enabled, default: true

      t.timestamps
    end
  end
end
