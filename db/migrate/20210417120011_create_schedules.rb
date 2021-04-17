class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.time :opens_at
      t.time :closes_at
      t.integer :weekday
      t.references :space, null: false, foreign_key: true

      t.timestamps
    end
  end
end
