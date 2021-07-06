class CreateUserGroupUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_group_users do |t|
      t.integer :user_group_id
      t.integer :user_id

      t.timestamps
    end
  end
end
