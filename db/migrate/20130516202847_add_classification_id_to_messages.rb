class AddClassificationIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :classification_id, :integer
  end
end
