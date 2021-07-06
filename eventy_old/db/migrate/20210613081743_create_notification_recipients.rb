class CreateNotificationRecipients < ActiveRecord::Migration[6.1]
  def change
    create_table :notification_recipients do |t|
      t.integer :notification_id
      t.integer :user_id
      t.boolean :is_read, default: false

      t.timestamps
    end
  end
end
