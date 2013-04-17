class RenameEventsToMessengerEvents < ActiveRecord::Migration
  def change
    rename_table :events, :messenger_events
  end
end
