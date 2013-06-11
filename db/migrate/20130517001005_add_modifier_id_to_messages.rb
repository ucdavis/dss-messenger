class AddModifierIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :modifier_id, :integer
  end
end
