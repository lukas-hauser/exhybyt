class StripePaymentIntentService
  def call(event)
    reservation = Reservation.find_by(payment_intent_id: event.data.object.payment_intent.succeeded)
    reservation.update(payment_captured: true)
  end
end
