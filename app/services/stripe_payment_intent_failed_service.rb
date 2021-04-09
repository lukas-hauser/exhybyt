class StripePaymentIntentFailedService
  def call(event)
    reservation = Reservation.find_by(payment_intent_id: event.data.object.id)
    reservation.update(payment_captured: false,
    status: "Payment failed")
#    reservation.approve
#    reservation.send_request_approval_email
    flash[:success] = "Payment failed. Can't approve."
  end
end
