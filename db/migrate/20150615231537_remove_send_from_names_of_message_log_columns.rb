class RemoveSendFromNamesOfMessageLogColumns < ActiveRecord::Migration
  def change
    rename_column :message_logs, :send_status, :status
    rename_column :message_logs, :send_start, :start
    rename_column :message_logs, :send_finish, :finish
  end
end
