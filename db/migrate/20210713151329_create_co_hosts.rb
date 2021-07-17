# frozen_string_literal: true

class CreateCoHosts < ActiveRecord::Migration[6.1]
  def change
    create_table :co_hosts do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
