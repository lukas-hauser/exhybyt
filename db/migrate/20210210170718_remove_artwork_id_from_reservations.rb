# frozen_string_literal: true

class RemoveArtworkIdFromReservations < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :artwork_id
  end
end
