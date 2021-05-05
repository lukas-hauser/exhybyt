# frozen_string_literal: true

class StripePaymentIntentService
  def call(event)
    reservation = Reservation.find_by(payment_intent_id: event.data.object.id)
    #    else # There is currently no Payment Intent ID for Orders
    #      order = Order.find_by(payment_intent_id: event.data.object.id)
    #      order.update(status: "Payment Captured")
    reservation&.update(payment_captured: true,
                        status: 'Confirmed and paid')
  end
end
