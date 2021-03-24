class ReservationsController < ApplicationController
  before_action :logged_in_user,      except: [:current_exhibitions, :past_exhibitions, :upcoming_exhibitions]
  before_action :active_space,          only: [:create]
  before_action :approved_reservations, only: [:current_exhibitions, :past_exhibitions, :upcoming_exhibitions]

  def preload
    space = Space.find(params[:space_id])
    today = Date.today
    reservations = space.reservations.where(rejected:false)
    reservations = reservations.where("DATE(start_date) >= ? OR DATE(end_date) >= ?", today, today)
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
    @exhibitions = @reservations.where("DATE(start_date) <= ? AND DATE(end_date) >= ?", today, today)
  end

  def past_exhibitions
    today = Date.today
    @exhibitions = @reservations.where("DATE(start_date) < ? AND DATE(end_date) < ?", today, today)
  end

  def upcoming_exhibitions
    today = Date.today
    @exhibitions = @reservations.where("DATE(start_date) > ? AND DATE(end_date) > ?", today, today)
  end

  def create
    @reservation = current_user.reservations.create(reservation_params)
    if @reservation.save
      redirect_to @reservation.space
      flash[:success] = "You have submited the reservation."
    else
      redirect_to request.referrer || root_path
      flash[:danger] = "Something went wrong. We couldn't submit your booking."
    end
  end

  private
    def is_conflict(start_date, end_date)
      space = Space.find(params[:space_id])

      reservations = space.reservations.where(rejected:false)
      check = reservations.where("? < DATE(start_date) AND DATE(end_date) < ?", start_date, end_date)
      check.size > 0? true : false
    end

    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :price, :total, :space_id, artwork_ids: [])
    end

    # Confirms an active space
    def active_space
      @space = Space.find(params[:space_id])
      if !@space.active?
        redirect_to root_url
        flash[:warning] = "Space is inactive. We can't submit your booking."
      end
    end

    # Confirms a reservatin was approved
    def approved_reservations
      @reservations = Reservation.where(approved:true)
    end
end
