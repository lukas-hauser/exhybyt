class ReservationRejectionsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

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

  private

  def correct_user
    @reservation = current_user.reservations.find_by(id: params[:id])
    redirect_to root_url if @reservation.nil?
  end
end
