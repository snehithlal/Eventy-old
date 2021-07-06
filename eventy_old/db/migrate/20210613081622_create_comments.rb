class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :event_id
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end
end
