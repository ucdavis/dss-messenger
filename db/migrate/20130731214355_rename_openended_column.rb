class RenameOpenendedColumn < ActiveRecord::Migration
  def change
    rename_column :modifiers, :openended, :open_ended
  end
end
