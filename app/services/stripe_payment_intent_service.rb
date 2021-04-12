class StripePaymentIntentService
  def call(event)
    reservation = Reservation.find_by(payment_intent_id: event.data.object.id)
    if !reservation.nil?
      reservation.update(payment_captured: true,
      status: "Confirmed and paid")
    else
      order = Order.find_by(payment_intent_id: event.data.object.id)
      order.update(status: "Payment Captured")
    end
  end
end
