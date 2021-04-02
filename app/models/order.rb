class Order < ApplicationRecord
  belongs_to :artwork
  belongs_to :user

  validates :price, presence: true
  validates :delivery_fee, presence: true
  validates :total, presence: true
  validates :user_id, presence: true

  default_scope -> { order(created_at: :desc) }

  # Sends order confirmation email
  def send_order_confirmation_email
    OrderMailer.request_confirmation(self).deliver_now
  end

  # Sends order notification email
  def send_order_notification_email
    OrderMailer.request_notification(self).deliver_now
  end

end
