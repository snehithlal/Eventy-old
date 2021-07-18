# frozen_string_literal: true

class CreateGroupUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_users do |t|
      t.references :group
      t.references :user
      t.timestamps

      t.index [:group_id, :user_id], unique: true
    end
  end
end
