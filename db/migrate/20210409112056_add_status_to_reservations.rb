# frozen_string_literal: true

class AddStatusToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :status, :string
  end
end
