class ReservationApprovalsController < ApplicationController
  def edit
    reservation = Reservation.find(params[:id])
    if reservation.approved?
      flash[:warning] = "You already approved this reservation."
    elsif reservation.rejected?
      flash[:danger] = "You already rejected this reservation."
    else
      reservation.approve
      flash[:success] = "Reservation approved."
    end
    redirect_to your_reservations_path
  end
end
