# frozen_string_literal: true

class CreateCircles < ActiveRecord::Migration[6.1]
  def change
    create_table :circles do |t|
      t.string :name
      t.text :description
      t.references :head, null: false, foreign_key: { to_table: :users }
      t.text :members

      t.timestamps
    end
  end
end
