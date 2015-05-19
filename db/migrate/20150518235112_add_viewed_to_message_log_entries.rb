class AddViewedToMessageLogEntries < ActiveRecord::Migration
  def change
    add_column :message_log_entries, :viewed, :bool
  end
end
