class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :messages, :id
    add_index :classifications, :id
    add_index :impacted_services, :id
    add_index :modifiers, :id
    add_index :recipients, :id
    add_index :recipients, :uid
    add_index :settings, :id
  end
end
