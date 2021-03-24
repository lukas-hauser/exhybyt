class ReservationRejectionsController < ApplicationController
  def edit
    reservation = Reservation.find(params[:id])
    if reservation.approved?
      flash[:danger] = "You already approved this reservation."
    elsif reservation.rejected?
      flash[:warning] = "You already rejected this reservation."
    else
      reservation.reject
      flash[:success] = "Reservation rejected."
    end
    redirect_to your_reservations_path
  end
end
