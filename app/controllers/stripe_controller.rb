class StripeController < ApplicationController
  before_action :logged_in_user, only: [:connect, :dashboard]
  before_action :correct_user,   only: [:dashboard]

  def connect
    response = HTTParty.post("https://connect.stripe.com/oauth/token",
      query: {
        client_secret: ENV["STRIPE_SECRET_KEY"],
        code: params[:code],
        grant_type: "authorization_code"
      })

    if response.parsed_response.key?("error")
      redirect_to edit_user_path(current_user)
      flash[:danger] = response.parsed_response["error_description"]
    else
      stripe_user_id = response.parsed_response["stripe_user_id"]
      current_user.update_attribute(:stripe_user_id, stripe_user_id)

      redirect_to edit_user_path(current_user)
      flash[:success] = "Successfully connected with Stripe."
    end
  end

  def dashboard
    account = Stripe::Account.retrieve(current_user.stripe_user_id)
    login_links = account.login_links.create

    redirect_to login_links.url
  end

  private

  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
