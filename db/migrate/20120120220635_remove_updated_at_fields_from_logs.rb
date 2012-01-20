class RemoveUpdatedAtFieldsFromLogs < ActiveRecord::Migration
  def up
    remove_column :logs, :updated_at
    remove_column :log_details, :updated_at
  end

  def down
    add_column :logs, :updated_at, :datetime
    add_column :log_details, :updated_at, :datetime
  end
end
