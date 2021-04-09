class StripePaymentIntentService
  def call(event)
    reservation = Reservation.find_by(payment_intent_id: event.data.object.id)
    reservation.update(payment_captured: true,
    status: "Confirmed and paid")
  end
end
