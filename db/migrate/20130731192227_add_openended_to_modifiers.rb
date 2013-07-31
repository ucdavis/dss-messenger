class AddOpenendedToModifiers < ActiveRecord::Migration
  def change
    add_column :modifiers, :openended, :boolean
  end
end
