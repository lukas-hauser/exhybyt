class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :active_artwork,        only: [:create]
  before_action :artwork_for_sale,      only: [:create]
  before_action :stripe_ready,          only: [:create]
  before_action :set_order,             only: [:success, :cancel]

  def index
    @orders = current_user.orders.paginate(page: params[:page])
  end

  def your_orders
    @orders = current_user.orders.paginate(page: params[:page])
  end

  def your_sales
    @sales = current_user.artworks
  end

  def create
    @order = current_user.orders.create(order_params)
    if @order.save
      session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
       price_data: {
         unit_amount: (@order.total * 100).to_i,
         currency: @order.artwork.user.currency,
         product_data: {
           name: @order.artwork.listing_name,
           images: ['https://safe-depths-41741.herokuapp.com/assets/favicon-ae299e626732d66b77774d9fd96cca12077323c7b4d7502877b83ab225374708.png'],
         },
       },
       quantity: 1,
      }],
      mode: 'payment',
      payment_intent_data: {
        application_fee_amount: (@order.artwork.price * 100 * 0.15).to_i,
        transfer_data:{
          destination: @order.artwork.user.stripe_user_id,
        }
      },
      success_url: "#{success_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "#{cancel_url}?session_id={CHECKOUT_SESSION_ID}",
      })

      @order.update(checkout_session_id: session.id)
      redirect_to order_payment_url(@order.id)
    else
      redirect_to request.referrer || root_path
      flash[:danger] = "Something went wrong. We couldn't submit your booking."
    end
  end

  def payment
    @order = Order.find(params[:order_id])
  end

  def success
    flash[:primary] = "You have submited the order."
  end

  def cancel
    flash[:danger] = "Something went wrong. We couldn't submit your order. You can try again or contact us."
  end

  private

    def order_params
      params.require(:order).permit(:price, :artwork_id)
    end

    # Confirms an active space
    def active_artwork
      @artwork = Artwork.find(params[:artwork_id])
      if !@artwork.active?
        redirect_to root_url
        flash[:warning] = "Artwork is inactive. We can't submit your order."
      end
    end

    def artwork_for_sale
      @artwork = Artwork.find(params[:artwork_id])
      if @artwork.status != "For Sale"
        redirect_to root_url
        flash[:warning] = "Artwork is not for sale. We can't submit your order."
      end
    end

    def stripe_ready
      @artwork = Artwork.find(params[:artwork_id])
      if @artwork.user.stripe_user_id.nil?
        redirect_to root_url
        flash[:danger] = "This artist is not ready yet to accept payments. Stay tuned.."
      end
    end

    def set_order
      @order = Order.find_by(checkout_session_id: params[:session_id])
    end
end
