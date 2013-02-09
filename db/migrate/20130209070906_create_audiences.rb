class CreateAudiences < ActiveRecord::Migration
  def change
    create_table :audiences do |t|
      t.integer :message_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
