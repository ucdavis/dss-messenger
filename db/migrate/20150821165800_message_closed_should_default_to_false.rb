class MessageClosedShouldDefaultToFalse < ActiveRecord::Migration
  def change
    change_column_default :messages, :closed, false
  end
end
