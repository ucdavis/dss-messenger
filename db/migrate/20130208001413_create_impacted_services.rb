class CreateImpactedServices < ActiveRecord::Migration
  def change
    create_table :impacted_services do |t|
      t.string :name

      t.timestamps
    end
  end
end
