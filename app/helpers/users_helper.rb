module UsersHelper
  def gravatar_for(user, size: 80, default: 'mp' ) # Rack::Utils.escape(asset_path('favicon.png'))
    if user.image.attached?
      image_tag(user.image, size: size, class:"gravatar rounded-circle")
    else
      gravatar_id   = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url  = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=#{default}&s=#{size}"
      image_tag(gravatar_url, alt: user.display_name, class: "gravatar rounded-circle" )
    end
  end

  def stripe_button_link
    stripe_url   = "https://connect.stripe.com/express/oauth/authorize"
    redirect_uri = stripe_connect_url
    client_id    = ENV["STRIPE_CLIENT_ID"]

    "#{stripe_url}?redirect_uri=#{redirect_uri}&client_id=#{client_id}"
  end

  def needs_stripe?
    !current_user.stripe_user_id? && (current_user.spaces.where(active: true).any? ||
    current_user.artworks.where(status:"For Sale").any?)
  end

  def pending_reservations?
#    current_user.spaces.each do |space|
#      space.reservations.where("approved = ? AND rejected = ? AND payment_completed = ? AND created_at > ? AND status != ?", false, false, true, 48.hours.ago, "Payment Intent Cancelled").any?
#    end
  end
end
