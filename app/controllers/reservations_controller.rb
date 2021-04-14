class ReservationsController < ApplicationController
  before_action :logged_in_user,      except: [:current_exhibitions, :past_exhibitions, :upcoming_exhibitions]
  before_action :active_space,          only: [:create]
  before_action :stripe_ready,          only: [:create]
  before_action :approved_reservations, only: [:current_exhibitions, :past_exhibitions, :upcoming_exhibitions]
  before_action :set_reservation,       only: [:success, :cancel]
  before_action :correct_user,          only: [:show]
  before_action :own_space,             only: [:create]

  def preload
    space = Space.find(params[:space_id])
    today = Date.today
    confirmed_bookings = space.reservations.where(approved:true)
    reservations = confirmed_bookings.where("DATE(start_date) >= ? OR DATE(end_date) >= ?", today, today)
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

  def show
  end

  def index
    @reservations = current_user.reservations.where(payment_completed:true).paginate(page: params[:page])
  end

  def your_bookings
    @bookings = current_user.reservations.where(payment_completed:true).paginate(page: params[:page])
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
    @reservation = current_user.reservations.build(reservation_params)
    @space = Space.find(params[:space_id])

    start_date = Date.parse(reservation_params[:start_date])
    end_date = Date.parse(reservation_params[:end_date])
    days = (end_date - start_date).to_i + 1

    @reservation.space = @space
    @reservation.currency = @space.user.currency
    @reservation.price = @space.price
    @reservation.total = @space.price * days
    @reservation.status = "Request incomplete"

    if @reservation.save
      session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      customer_email: @reservation.user.email,
      line_items: [{
       price_data: {
         unit_amount: (@reservation.total * 100).to_i,
         currency: @reservation.currency,
         product_data: {
           name: @reservation.space.listing_name,
           images: ['https://safe-depths-41741.herokuapp.com/assets/favicon-ae299e626732d66b77774d9fd96cca12077323c7b4d7502877b83ab225374708.png'],
         },
       },
       quantity: 1,
      }],
      mode: 'payment',
      payment_intent_data: {
        capture_method: "manual",
        application_fee_amount: (@reservation.total * 100 * 0.15).to_i,
        transfer_data:{
          destination: @reservation.space.user.stripe_user_id,
        }
      },
      success_url: "#{reservation_success_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "#{reservation_cancel_url}?session_id={CHECKOUT_SESSION_ID}",
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
    @reservation.send_request_confirmation_email
    @reservation.send_request_notification_email
    redirect_to @reservation
    flash[:primary] = "Thank you - we received your booking request and emailed you the details to #{ @reservation.user.email }. #{ @reservation.space.listing_name} has 48 hours to approve your request."
  end

  def cancel
    redirect_to root_path
    flash[:danger] = "Something went wrong. We couldn't submit your booking. You can try again or contact us."
  end

  private
    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, artwork_ids: [])
    end

    # Confirms that there is no approved booking for the requested dates.
    def is_conflict(start_date, end_date)
      space = Space.find(params[:space_id])

      reservations = space.reservations.where(approved:true)
      check = reservations.where("? < DATE(start_date) AND DATE(end_date) < ?", start_date, end_date)
      check.size > 0? true : false
    end

    # Confirms an active space
    def active_space
      @space = Space.find(params[:space_id])
      if !@space.active?
        redirect_to root_url
        flash[:warning] = "Space is inactive. We can't submit your booking."
      end
    end

    # Confirms it's not their own space
    def own_space
      @space = Space.find(params[:space_id])
      if current_user?(@space.user)
        redirect_to root_url
        flash[:danger] = "You can't book your own space."
      end
    end

    # Confirms Space Listing Owner is ready to accept payments
    def stripe_ready
      @space = Space.find(params[:space_id])
      if @space.user.stripe_user_id.nil?
        redirect_to root_url
        flash[:danger] = "This space is not ready yet to accept payments. Stay tuned.."
      end
    end

    # Confirms a reservation was approved
    def approved_reservations
      @reservations = Reservation.where(approved:true)
    end

    def set_reservation
      @reservation = Reservation.find_by(checkout_session_id: params[:session_id])
    end

    #Confirms that user is either space listing owner or reservation user
    def correct_user
      @reservation = Reservation.find_by(id: params[:id])
      @yourreservation = current_user.reservations.find_by(id: params[:id])
      if !current_user?(@reservation.space.user) && @yourreservation.nil?
        redirect_to root_url
        flash[:danger] = "You're not authorised"
      end
    end
end
