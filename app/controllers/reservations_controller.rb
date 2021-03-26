class ReservationsController < ApplicationController
  before_action :logged_in_user,      except: [:current_exhibitions, :past_exhibitions, :upcoming_exhibitions]
  before_action :active_space,          only: [:create]
  before_action :approved_reservations, only: [:current_exhibitions, :past_exhibitions, :upcoming_exhibitions]
  before_action :set_reservation,       only: [:success, :cancel]

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
      session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
       price_data: {
         unit_amount: (@reservation.total * 100).to_i,
         currency: 'gbp',
         product_data: {
           name: @reservation.space.listing_name,
           images: ['https://safe-depths-41741.herokuapp.com/assets/favicon-ae299e626732d66b77774d9fd96cca12077323c7b4d7502877b83ab225374708.png'],
         },
       },
       quantity: 1,
      }],
      mode: 'payment',
      payment_intent_data: {
        application_fee_amount: (@reservation.total * 100 * 0.15).to_i,
        transfer_data:{
          destination: @reservation.space.user.stripe_user_id,
        }
      },
      success_url: "#{success_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "#{cancel_url}?session_id={CHECKOUT_SESSION_ID}",
      })

      @reservation.update(checkout_session_id: session.id)
      redirect_to reservation_payment_url(@reservation.id)
    else
      redirect_to request.referrer || root_path
      flash[:danger] = "Something went wrong. We couldn't submit your booking."
    end
  end

  def payment
    @reservation = Reservation.find(params[:reservation_id])
  end

  def success
    flash[:primary] = "You have submited the reservation."
  end

  def cancel
    flash[:danger] = "Something went wrong. We couldn't submit your booking. You can try again or contact us."
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

    def set_reservation
      @reservation = Reservation.find_by(checkout_session_id: params[:session_id])
    end
end
