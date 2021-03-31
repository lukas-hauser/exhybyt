class AddPaymentIntentIdToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :payment_intent_id, :string
    add_column :reservations, :payment_captured, :boolean, default:false
  end
end
