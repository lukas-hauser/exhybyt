# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :artwork_for_sale,  only: [:create]
  before_action :own_art,           only: [:create]
  before_action :stripe_ready,      only: [:create]
  before_action :set_order,         only: %i[success cancel]

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
    @order = current_user.orders.build
    @artwork = Artwork.find(params[:artwork_id])

    @order.artwork = @artwork
    @order.currency = @artwork.user.currency
    @order.price = @artwork.price
    @order.total = @artwork.price + @order.delivery_fee

    if @order.save
      session = Stripe::Checkout::Session.create({
                                                   payment_method_types: ['card'],
                                                   customer_email: @order.user.email,
                                                   line_items: [{
                                                     price_data: {
                                                       unit_amount: (@order.total * 100).to_i,
                                                       currency: @order.currency,
                                                       product_data: {
                                                         name: @order.artwork.listing_name,
                                                         images: ['https://safe-depths-41741.herokuapp.com/assets/favicon-ae299e626732d66b77774d9fd96cca12077323c7b4d7502877b83ab225374708.png']
                                                       }
                                                     },
                                                     quantity: 1
                                                   }],
                                                   mode: 'payment',
                                                   payment_intent_data: {
                                                     application_fee_amount: (@order.total * 100 * 0.15).to_i,
                                                     transfer_data: {
                                                       destination: @order.artwork.user.stripe_user_id
                                                     }
                                                   },
                                                   success_url: "#{order_success_url}?session_id={CHECKOUT_SESSION_ID}",
                                                   cancel_url: "#{order_cancel_url}?session_id={CHECKOUT_SESSION_ID}"
                                                 })

      @order.update(checkout_session_id: session.id)
      redirect_to order_payment_url(@order.id)
    else
      redirect_to request.referer || root_path
      flash[:danger] = "Something went wrong. We couldn't submit your booking."
    end
  end

  def payment
    @order = Order.find(params[:order_id])
  end

  def success
    @order.send_order_confirmation_email
    @order.send_order_notification_email
    flash[:primary] = 'You have submited the order.'
    redirect_to artwork_path(@order.artwork)
  end

  def cancel
    flash[:danger] = "Something went wrong. We couldn't submit your order. You can try again or contact us."
  end

  private

  # Confirms that artwork is for sale
  def artwork_for_sale
    @artwork = Artwork.find(params[:artwork_id])
    return unless @artwork.status != 'For Sale'

    redirect_to root_url
    flash[:warning] = "Artwork is not for sale. We can't submit your order."
  end

  # Confirms that artists can't buy their own art
  def own_art
    @artwork = Artwork.find(params[:artwork_id])
    return unless current_user?(@artwork.user)

    redirect_to root_url
    flash[:danger] = "You can't buy your own art."
  end

  # Confirms that artists are ready to accept payments to sell their art
  def stripe_ready
    @artwork = Artwork.find(params[:artwork_id])
    return unless @artwork.user.stripe_user_id.empty?

    redirect_to root_url
    flash[:danger] = 'This artist is not ready yet to accept payments. Stay tuned..'
  end

  def set_order
    @order = Order.find_by(checkout_session_id: params[:session_id])
  end
end
