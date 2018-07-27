class DropBroadcastsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :broadcasts
  end
end
