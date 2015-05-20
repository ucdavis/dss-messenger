class AddViewedCountToMessageLog < ActiveRecord::Migration
  def change
    add_column :message_logs, :viewed_count, :integer, default: 0
  end
end
