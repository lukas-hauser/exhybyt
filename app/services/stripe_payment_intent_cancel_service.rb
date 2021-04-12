class StripePaymentIntentCancelService
  def call(event)
    reservation = Reservation.find_by(payment_intent_id: event.data.object.id)
    if !reservation.nil?
      reservation.update(payment_captured: false,
        status: "Payment Intent Cancelled.")
    else
      order = Order.find_by(payment_intent_id: event.data.object.id)
      order.update(payment_completed: false,
         status: "Payment Intent Cancelled.")
   end
  end
end
