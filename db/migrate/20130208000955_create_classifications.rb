class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications do |t|
      t.string :description

      t.timestamps
    end
  end
end
