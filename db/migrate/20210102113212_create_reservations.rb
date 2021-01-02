class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :space, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.float :price
      t.float :total

      t.timestamps
    end
  end
end
