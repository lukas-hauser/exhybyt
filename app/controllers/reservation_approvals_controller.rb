class ReservationApprovalsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user
  before_action :check_expiration
  before_action :payment_completed

  def edit
    reservation = Reservation.find(params[:id])
    if reservation.approved?
      flash[:warning] = "You already approved this reservation."
    elsif reservation.rejected?
      flash[:danger] = "You already rejected this reservation."
    else
      Stripe::PaymentIntent.capture(
        reservation.payment_intent_id,
      )
      reservation.approve
      flash[:success] = "Reservation approved."
    end
    redirect_to reservation
  end

  private

    # Confirms that user is reservation space listing owner
    def correct_user
      @reservation = Reservation.find(params[:id])
      if !current_user?(@reservation.space.user)
        redirect_to root_url
        flash[:danger] = "You are not authorised."
      end
    end

    # Checks expiration of the booking request
    def check_expiration
      if @reservation.booking_request_expired?
        flash[:danger] = "Booking request has expired."
        redirect_to your_reservations_path
      end
    end

    # Confirms a checkout session is completed
    def payment_completed
      unless @reservation.payment_completed?
        flash[:danger] = "Can't approve this incomplete booking request."
        redirect_to your_reservations_path
      end
    end

    # Confirm that dates to approve are available
    def available_dates
    end
end
