class ReservationApprovalsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user
  before_action :check_expiration
  before_action :payment_completed
  before_action :overlapping_dates
  before_action :set_reservation,       only: [:success, :cancel]


  def edit
    reservation = Reservation.find(params[:id])
    if reservation.approved?
      flash[:warning] = "You already approved this reservation."
    elsif reservation.rejected?
      flash[:danger] = "You already rejected this reservation."
    else
      Stripe::PaymentIntent.capture(
        reservation.payment_intent_id,
        success_url: "#{reservation_approval_success_url}?payment_intent_id={PAYMENT_INTENT_ID}",
        cancel_url: "#{reservation_approval_cancel_url}?payment_intent_id={PAYMENT_INTENT_ID}",
      )
    end
    redirect_to reservation
  end

  def success
    reservation.approve
    reservation.send_request_approval_email
    redirect_to @reservation
    flash[:success] = "Reservation approved."
  end

  def cancel
    redirect_to @reservation
    flash[:danger] = "Something went wrong. The payment couldn't be processed and the booking was cancelled."
  end

  private

    def set_reservation
      @reservation = Reservation.find_by(checkout_session_id: params[:session_id])
    end

    # Confirms that user is reservation space listing owner
    def correct_user
      reservation = Reservation.find(params[:id])
      if !current_user?(reservation.space.user)
        redirect_to root_url
        flash[:danger] = "You are not authorised."
      end
    end

    # Checks expiration of the booking request
    def check_expiration
      reservation = Reservation.find(params[:id])
      if reservation.booking_request_expired?
        flash[:danger] = "Booking request has expired."
        redirect_to your_reservations_path
      end
    end

    # Confirms a checkout session is completed
    def payment_completed
      reservation = Reservation.find(params[:id])
      unless reservation.payment_completed?
        flash[:danger] = "Can't approve this incomplete booking request."
        redirect_to your_reservations_path
      end
    end

    # Confirm that dates to approve are available
    def overlapping_dates
      reservation = Reservation.find(params[:id])
      space = reservation.space

      start_date = reservation.start_date.to_date
      end_date = reservation.end_date.to_date

      confirmed_bookings = space.reservations.where(approved:true)

      check = confirmed_bookings.where("? <= DATE(start_date) AND DATE(end_date) <= ?", start_date, end_date)
      if check.any?
        flash[:danger] = "You already confirmed another booking request with overlapping dates."
        redirect_to your_reservations_path
      end
    end
end
