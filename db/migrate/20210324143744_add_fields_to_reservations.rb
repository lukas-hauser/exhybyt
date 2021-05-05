# frozen_string_literal: true

class AddFieldsToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :approved, :boolean, default: false
    add_column :reservations, :approved_at, :datetime
    add_column :reservations, :rejected, :boolean, default: false
    add_column :reservations, :rejected_at, :datetime
  end
end
