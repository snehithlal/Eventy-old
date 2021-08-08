# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :host_id, index: true
      t.string :title
      t.text :description
      t.string :place
      t.datetime :start_time
      t.datetime :end_time
      t.text :review
      t.boolean :chat_enabled, default: false
      t.boolean :quick_event, default: false
      t.boolean :completed, default: false

      t.timestamps
      t.index [:start_time, :end_time]
    end
  end
end
