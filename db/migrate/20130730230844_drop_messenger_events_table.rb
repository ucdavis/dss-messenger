class DropMessengerEventsTable < ActiveRecord::Migration
  def change
    drop_table :messenger_events
  end

end
