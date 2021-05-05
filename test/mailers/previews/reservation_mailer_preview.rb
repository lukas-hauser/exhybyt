# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class ReservationMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/reservation_mailer/request_notification
  def request_notification
    reservation = Reservation.first
    ReservationMailer.request_notification(reservation)
  end

  # Preview this email at http://localhost:3000/rails/mailers/reservation_mailer/request_confirmation
  def request_confirmation
    reservation = Reservation.first
    ReservationMailer.request_confirmation(reservation)
  end

  # Preview this email at http://localhost:3000/rails/mailers/reservation_mailer/request_approval
  def request_approval
    reservation = Reservation.first
    ReservationMailer.request_approval(reservation)
  end

  # Preview this email at http://localhost:3000/rails/mailers/reservation_mailer/request_rejection
  def request_rejection
    reservation = Reservation.first
    ReservationMailer.request_rejection(reservation)
  end
end
