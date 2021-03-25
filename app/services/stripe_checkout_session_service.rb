class StripeCheckoutSessionService
  def call(event)
    reservation = Reservation.find_by(checkout_session_id: event.data.object.id)
    reservation.update(payment_completed: true)
  end
end
