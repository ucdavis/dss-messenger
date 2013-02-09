class CreateBroadcasts < ActiveRecord::Migration
  def change
    create_table :broadcasts do |t|
      t.integer :message_id
      t.integer :event_id

      t.timestamps
    end
  end
end
