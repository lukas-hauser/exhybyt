class StripeCheckoutSessionService
  def call(event)
    reservation = Reservation.find_by(checkout_session_id: event.data.object.id)
    if !reservation.nil?
      reservation.update(payment_completed: true,
        payment_intent_id: event.data.object.payment_intent,
        status: "Awaiting response from space")
    else
      order = Order.find_by(checkout_session_id: event.data.object.id)
      order.update(payment_completed: true)
      order.artwork.update(status: "Sold")
    end
  end
end
