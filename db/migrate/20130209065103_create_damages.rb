class CreateDamages < ActiveRecord::Migration
  def change
    create_table :damages do |t|
      t.integer :message_id
      t.integer :impacted_service_id

      t.timestamps
    end
  end
end
