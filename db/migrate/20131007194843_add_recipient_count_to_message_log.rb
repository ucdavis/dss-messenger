class AddRecipientCountToMessageLog < ActiveRecord::Migration
  def change
    add_column :message_logs, :recipient_count, :integer
  end
end
