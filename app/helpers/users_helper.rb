module UsersHelper
  def gravatar_for(user, size: 80 )
    gravatar_id   = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url  = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.display_name, class: "gravatar rounded-circle" )
  end

  def stripe_button_link
    stripe_url   = "https://connect.stripe.com/express/oauth/authorize"
    redirect_uri = stripe_connect_url
    client_id    = ENV["STRIPE_CLIENT_ID"]

    "#{stripe_url}?redirect_uri=#{redirect_uri}&client_id=#{client_id}"
  end
end
