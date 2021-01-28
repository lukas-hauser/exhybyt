class AddArtToReservations < ActiveRecord::Migration[6.1]
  def change
    add_reference :reservations, :artwork, null: false, foreign_key: true
  end
end
