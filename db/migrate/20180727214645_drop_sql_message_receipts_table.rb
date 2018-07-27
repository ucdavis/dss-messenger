class DropSqlMessageReceiptsTable < ActiveRecord::Migration[5.2]
  def change
    # Message receipts are stored in DynamoDB now
    drop_table :message_receipts
  end
end
