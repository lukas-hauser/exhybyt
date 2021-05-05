# frozen_string_literal: true

class AddCheckoutSessionIdToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :checkout_session_id, :string
    add_column :reservations, :payment_completed, :boolean, default: false
  end
end
