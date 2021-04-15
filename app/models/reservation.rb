class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :space

  has_many :reservation_artworks
  has_many :artworks, through: :reservation_artworks
  has_many :reviews

  validates :price, presence: true, numericality: {:greater_than_or_equal_to => 1}
  validates :total, presence: true, numericality: {:greater_than_or_equal_to => 1}
  validates :user_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate  :end_date_after_start_date
  validates :artwork_ids, presence: true
  validates :currency, presence: true

  default_scope -> { order(created_at: :desc) }

  # Approves a reservation
  def approve
    update_columns(approved: true, approved_at: Time.zone.now,
                   rejected: false)
  end

  # Rejects a reservation
  def reject
    update_columns(rejected: true, rejected_at: Time.zone.now,
                   approved: false, status:"Rejected")
  end

  # Returns true if a password reset has expired
  def booking_request_expired?
    created_at < 48.hours.ago
  end

  # Returns true if a payment_intent was cancelled
  def payment_intent_cancelled?
    status == "Payment Intent Cancelled"
  end

  # Sends booking request confirmation email
  def send_request_confirmation_email
    ReservationMailer.request_confirmation(self).deliver_now
  end

  # Sends booking request notification email
  def send_request_notification_email
    ReservationMailer.request_notification(self).deliver_now
  end

  def send_request_approval_email
    ReservationMailer.request_approval(self).deliver_now
  end

  def send_request_rejection_email
    ReservationMailer.request_rejection(self).deliver_now
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
