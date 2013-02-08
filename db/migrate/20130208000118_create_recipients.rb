class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.string :uid

      t.timestamps
    end
  end
end
