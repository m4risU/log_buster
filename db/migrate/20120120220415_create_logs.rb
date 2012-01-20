class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :type

      t.timestamps
    end
  end
end
