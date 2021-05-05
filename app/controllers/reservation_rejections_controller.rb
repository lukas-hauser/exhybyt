# frozen_string_literal: true

class ReservationRejectionsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user
  before_action :check_expiration
  before_action :payment_completed

  def edit
    reservation = Reservation.find(params[:id])
    if reservation.approved?
      flash[:danger] = 'You already approved this reservation.'
    elsif reservation.rejected?
      flash[:warning] = 'You already rejected this reservation.'
    elsif reservation.payment_intent_cancelled?
      flash[:danger] = "Payment was cancelled. You can't approve this request anymore."
    else
      Stripe::PaymentIntent.cancel(
        reservation.payment_intent_id
      )
      reservation.reject
      reservation.send_request_rejection_email
      flash[:success] = 'Reservation rejected.'
    end
    redirect_to reservation
  end

  private

  # Confirms that user is reservation space listing owner
  def correct_user
    @reservation = Reservation.find(params[:id])
    return if current_user?(@reservation.space.user)

    redirect_to root_url
    flash[:danger] = 'You are not authorised.'
  end

  # Checks expiration of the booking request
  def check_expiration
    return unless @reservation.booking_request_expired?

    flash[:danger] = 'Booking request has expired.'
    redirect_to your_reservations_path
  end

  def payment_completed
    return if @reservation.payment_completed?

    flash[:danger] = "Can't decline this incomplete booking request."
    redirect_to your_reservations_path
  end
end
