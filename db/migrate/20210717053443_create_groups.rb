# frozen_string_literal: true

class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.references :user
      t.timestamps

      t.index [:name, :user_id], unique: true
    end
  end
end
