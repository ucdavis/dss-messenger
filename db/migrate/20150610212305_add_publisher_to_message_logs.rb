class AddPublisherToMessageLogs < ActiveRecord::Migration
  def change
    add_column :message_logs, :publisher_id, :integer
    add_index :message_logs, :publisher_id
  end
end
