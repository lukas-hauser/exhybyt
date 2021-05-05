# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class OrderMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/order_notification
  def order_notification
    order = Order.first
    OrderMailer.order_notification(order)
  end

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/order_confirmation
  def order_confirmation
    order = Order.first
    OrderMailer.order_confirmation(order)
  end
end
