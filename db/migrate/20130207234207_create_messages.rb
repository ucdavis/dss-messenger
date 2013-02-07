class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :impact_statement
      t.datetime :window_start
      t.datetime :window_end
      t.text :purpose
      t.text :resolution
      t.text :workaround
      t.text :other_services
      t.string :sender_uid

      t.timestamps
    end
  end
end
