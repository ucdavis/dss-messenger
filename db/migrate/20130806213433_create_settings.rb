class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :item_name
      t.text :item_value

      t.timestamps
    end
  end
end
