class ChangeStatusColumnName < ActiveRecord::Migration
  def change
    rename_column :messages, :status, :closed
  end

end
