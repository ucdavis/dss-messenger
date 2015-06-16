class RenameClassToClassNameInPublisher < ActiveRecord::Migration
  def change
    rename_column :publishers, :class, :class_name
  end
end
