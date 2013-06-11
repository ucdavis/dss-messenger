class AddNameToRecipients < ActiveRecord::Migration
  def change
    add_column :recipients, :name, :string
  end
end
