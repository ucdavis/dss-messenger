class AddViewedToMessageLogEntries < ActiveRecord::Migration
  def change
    add_column :message_log_entries, :viewed, :boolean
  end
end
