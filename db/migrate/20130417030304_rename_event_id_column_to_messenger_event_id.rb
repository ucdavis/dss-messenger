class RenameEventIdColumnToMessengerEventId < ActiveRecord::Migration
  def self.up
    rename_column :broadcasts, :event_id, :messenger_event_id
  end

  def self.down
    rename_column :broadcasts, :messenger_event_id, :event_id
  end
end
