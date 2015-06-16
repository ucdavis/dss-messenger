class AddLoginIdToMessageReceipts < ActiveRecord::Migration
  def change
    add_column :message_receipts, :login_id, :string
  end
end
