class ReservationApprovalsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

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

  private

  def correct_user
    @reservation = current_user.reservations.find_by(id: params[:id])
    redirect_to root_url if @reservation.nil?
  end
end
