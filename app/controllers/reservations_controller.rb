class ReservationsController < ApplicationController
  before_action :logged_in_user, except: [:current_exhibitions, :past_exhibitions, :upcoming_exhibitions]

  def preload
    space = Space.find(params[:space_id])
    today = Date.today
    reservations = space.reservations.where("start_date >= ? OR end_date >= ?", today, today)
    render json: reservations
  end

  def preview
    start_date = Date.parse(params[:start_date])
    end_date   = Date.parse(params[:end_date])

    output = {
      conflict: is_conflict(start_date, end_date)
    }
    render json: output
  end

  def index
    @reservations = current_user.reservations.paginate(page: params[:page])
  end

  def your_bookings
    @bookings = current_user.reservations.paginate(page: params[:page])
  end

  def your_reservations
    @spaces = current_user.spaces
  end

  def current_exhibitions
    today = Date.today
    @exhibitions = Reservation.where("start_date <= ? AND end_date >= ?", today, today)
  end

  def past_exhibitions
    today = Date.today
    @exhibitions = Reservation.where("start_date <= ? AND end_date <= ?", today, today)
  end

  def upcoming_exhibitions
    today = Date.today
    @exhibitions = Reservation.where("start_date >= ? AND end_date >= ?", today, today)
  end

  def create
    @reservation = current_user.reservations.create(reservation_params)
    if @reservation.save
      redirect_to @reservation.space
      flash[:success] = "You have submited the reservation."
    else
      redirect_to request.referrer || root_path
      flash[:danger] = "Something went wrong. Have you already uploaded the artwork that you want to exhibit?"
    end
  end

  private
    def is_conflict(start_date, end_date)
      space = Space.find(params[:space_id])

      check = space.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
      check.size > 0? true : false
    end

    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :price, :total, :space_id, artwork_ids: [])
    end
end
