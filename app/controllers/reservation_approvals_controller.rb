# frozen_string_literal: true

class ReservationApprovalsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user
  before_action :check_expiration
  before_action :payment_completed
  before_action :overlapping_dates

  def edit
    reservation = Reservation.find(params[:id])
    if reservation.approved?
      flash[:warning] = 'You already approved this reservation.'
    elsif reservation.rejected?
      flash[:danger] = 'You already rejected this reservation.'
    elsif reservation.payment_intent_cancelled?
      flash[:danger] = "Payment was cancelled. You can't approve this request anymore."
    else
      if reservation.total != 0
        Stripe::PaymentIntent.capture(
          reservation.payment_intent_id
        )
      end
      reservation.approve
      reservation.send_request_approval_email
      flash[:success] = 'Reservation approved.'
    end
    redirect_to your_reservations_path
  end

  private

  # Confirms that user is reservation space listing owner
  def correct_user
    reservation = Reservation.find(params[:id])
    return if current_user?(reservation.space.user)

    redirect_to root_url
    flash[:danger] = 'You are not authorised.'
  end

  # Checks expiration of the booking request
  def check_expiration
    reservation = Reservation.find(params[:id])
    return unless reservation.booking_request_expired?

    flash[:danger] = 'Booking request has expired.'
    redirect_to your_reservations_path
  end

  # Confirms a checkout session is completed
  def payment_completed
    reservation = Reservation.find(params[:id])
    return if reservation.payment_completed?

    flash[:danger] = "Can't approve this incomplete booking request."
    redirect_to your_reservations_path
  end

  # Confirm that dates to approve are available
  def overlapping_dates
    reservation = Reservation.find(params[:id])
    space = reservation.space

    start_date = reservation.start_date.to_date
    end_date = reservation.end_date.to_date

    confirmed_bookings = space.reservations.where(approved: true)

    check = confirmed_bookings.where('? <= DATE(start_date) AND DATE(end_date) <= ?', start_date, end_date)
    return unless check.any?

    flash[:danger] = 'You already confirmed another booking request with overlapping dates.'
    redirect_to your_reservations_path
  end
end
