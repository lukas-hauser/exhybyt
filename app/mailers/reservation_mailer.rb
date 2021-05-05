# frozen_string_literal: true

class ReservationMailer < ApplicationMailer
  def request_notification(reservation)
    @reservation = reservation
    mail to: reservation.space.user.email, subject: 'New Booking Request'
  end

  def request_confirmation(reservation)
    @reservation = reservation
    mail to: reservation.user.email, subject: 'Booking Request Submitted'
  end

  def request_approval(reservation)
    @reservation = reservation
    mail to: reservation.user.email, subject: 'Booking Request Approved'
  end

  def request_rejection(reservation)
    @reservation = reservation
    mail to: reservation.user.email, subject: 'Booking Request Declined'
  end
end
