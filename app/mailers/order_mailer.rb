# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  def order_notification(order)
    @order = order
    mail to: order.artwork.user.email, subject: 'Someone bought your artwork!'
  end

  def order_confirmation(order)
    @order = order
    mail to: order.user.email, subject: 'Order Confirmation'
  end
end
