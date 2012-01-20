class CreateLogDetails < ActiveRecord::Migration
  def change
    create_table :log_details do |t|
      t.integer :log_id
      t.text :description

      t.timestamps
    end
  end
end
