class CreateMessageLogs < ActiveRecord::Migration
  def change
    create_table :message_logs do |t|
      t.integer :message_id
      t.timestamp :send_start
      t.timestamp :send_finish
      t.integer :send_status
      t.timestamps
    end
  end
end
