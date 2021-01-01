class HtmlPagesController < ApplicationController
  def home
    if logged_in?
      @space_feed_items = (current_user.space_feed).paginate(page: params[:page])
      @art_feed_items = (current_user.art_feed).paginate(page: params[:page])
    end
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
end
