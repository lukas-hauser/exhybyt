class HtmlPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
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
