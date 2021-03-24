class AddFieldsToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :stripe_id, :string
    add_column :reservations, :status, :string
    add_column :reservations, :paid_at, :datetime
  end
  add_index :reservations, :stripe_id
end
