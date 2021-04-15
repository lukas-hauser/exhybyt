class Order < ApplicationRecord
  belongs_to :artwork
  belongs_to :user

  validates :price, presence: true, numericality: {:greater_than_or_equal_to => 1}
  validates :delivery_fee, presence: true
  validates :total, presence: true, numericality: {:greater_than_or_equal_to => 1}
  validates :user_id, presence: true
  validates :currency, presence: true

  default_scope -> { order(created_at: :desc) }

  # Sends order confirmation email
  def send_order_confirmation_email
    OrderMailer.order_confirmation(self).deliver_now
  end

  # Sends order notification email
  def send_order_notification_email
    OrderMailer.order_notification(self).deliver_now
  end

end
