class AddPerformedAtToMessageReceipt < ActiveRecord::Migration
  def change
    add_column :message_receipts, :performed_at, :datetime, :default => nil
  end
end
