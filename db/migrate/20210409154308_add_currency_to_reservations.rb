# frozen_string_literal: true

class AddCurrencyToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :currency, :string
  end
end
