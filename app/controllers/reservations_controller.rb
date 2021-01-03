class ReservationsController < ApplicationController
  before_action :logged_in_user

  def index
    @reservations = current_user.reservations.paginate(page: params[:page])
  end

  def create
    @reservation = current_user.reservations.create(reservation_params)
    if @reservation.save
      redirect_to @reservation.space
      flash[:success] = "You have submited the reservation."
    else
      redirect_to request.referrer || root_path
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :price, :total, :space_id)
  end
end
