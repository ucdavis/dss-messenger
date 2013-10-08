class AddMessageIdIndexToMessageLog < ActiveRecord::Migration
  def change
    add_index :message_logs, :message_id
  end
end
