class CreateMessageLogEntries < ActiveRecord::Migration
  def change
    create_table :message_log_entries do |t|
      t.integer :message_log_id
      t.string :recipient_name
      t.string :recipient_email

      t.timestamps
    end
  end
end
