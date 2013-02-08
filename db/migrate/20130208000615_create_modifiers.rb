class CreateModifiers < ActiveRecord::Migration
  def change
    create_table :modifiers do |t|
      t.string :description

      t.timestamps
    end
  end
end
