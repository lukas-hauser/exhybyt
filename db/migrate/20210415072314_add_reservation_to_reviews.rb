class AddReservationToReviews < ActiveRecord::Migration[6.1]
  def change
    add_reference :reviews, :reservation, null: false, foreign_key: true
  end
end
