class HtmlPagesController < ApplicationController
  def home
    if logged_in?
      @space_feed_items = (current_user.space_feed).where(active:true).paginate(page: params[:page])
      @art_feed_items = (current_user.art_feed).paginate(page: params[:page])
    end
    @featured_artworks = Artwork.where(featured:true).take(10)
    @featured_spaces   = Space.take(3)
  end

  def search

  	if params[:search].present? && params[:search].strip != ""
  		session[:loc_search] = params[:search]
  	end

  	arrResult = Array.new

  	if session[:loc_search] && session[:loc_search] != ""
  		@spaces_address = Space.where(active: true).near(session[:loc_search], 5, order: 'distance')
  	else
  		@spaces_address = Space.where(active: true).all
  	end

  	@search = @spaces_address.ransack(params[:q])
  	@spaces = @search.result

  	@arrSpaces = @spaces.to_a

  	if (params[:start_date] && params[:end_date] && !params[:start_date].empty? & !params[:end_date].empty?)

  		start_date = Date.parse(params[:start_date])
  		end_date = Date.parse(params[:end_date])

  		@spaces.each do |space|

  			not_available = space.reservations.where(
  					"(? <= start_date AND start_date <= ?)
  					OR (? <= end_date AND end_date <= ?)
  					OR (start_date < ? AND ? < end_date)",
  					start_date, end_date,
  					start_date, end_date,
  					start_date, end_date
  				).limit(1)

  			if not_available.length > 0
  				@arrSpaces.delete(space)
  			end

  		end

  	end

  end

  def browse_art
    arrResult = Array.new

    @search = Artwork.all.ransack(params[:q])
    @artworks = @search.result

    @arrArtworks = @artworks.to_a
  end

  def help
  end

  def about
  end

  def howitworks
  end

  def terms
  end

  def privacypolicy
  end

  def cookiepolicy
  end

  def faq
    @faqs = Faq.all
  end
end
