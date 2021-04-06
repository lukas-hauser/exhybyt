class StripePaymentIntentService
  def call(event)
    reservation = Reservation.find_by(payment_intent_id: event.data.object.id)
    reservation.update(payment_captured: true) if event.data.object.payment_intent.succeeded?
  end
end
