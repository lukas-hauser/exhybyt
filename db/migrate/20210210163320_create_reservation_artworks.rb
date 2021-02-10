class CreateReservationArtworks < ActiveRecord::Migration[6.1]
  def change
    create_table :reservation_artworks do |t|
      t.integer :reservation_id
      t.integer :artwork_id
      t.timestamps
    end
  end
end
