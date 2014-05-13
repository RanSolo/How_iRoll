class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :person_id
      t.integer :location_id
      t.string :type
      t.string :date
      t.string :sub_type
      t.string :trip_time
      t.string :reason
      t.timestamps
    end
  end
end
