class ChangeMessageLogEntryToMessageReceipt < ActiveRecord::Migration
  def up
    rename_table :message_log_entries, :message_receipts
  end

  def down
    rename_table :message_receipts, :message_log_entries
  end
end
