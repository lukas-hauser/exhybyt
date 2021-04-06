class ArtworksController < ApplicationController
  before_action :set_artwork,       only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user,  except: [:show]
  before_action :correct_user,      only: [:edit, :update, :destroy]
  after_action  :stripe_ready,      only: [:create, :update]

  def index
#    @artworks = artwork.all
    @artworks = current_user.artworks.paginate(page: params[:page])
  end

  def show
  end

  def new
    @artwork = current_user.artworks.build if logged_in?
  end

  def create
    @artwork = current_user.artworks.build(artwork_params)
    @artwork.images.attach(params[:artwork][:images])
    if @artwork.save
      flash[:success] = "artwork saved."
      redirect_to @artwork
    else
      render :new
    end
  end

  def edit
  end

  def update
    unless params[:artwork][:images].nil?
      @artwork.images.attach(params[:artwork][:images])
    end
    if @artwork.update(artwork_params)
      redirect_to @artwork
      flash[:primary] = "artwork updated."
    else
      render :edit
    end
  end

  def destroy
    if @artwork.reservations.any?
      flash[:warning] = "Artwork currently can't be deleted as it was used in a reservation."
    else
      @artwork.destroy
      flash[:primary] = "artwork has been deleted"
    end
    redirect_to request.referrer || root_path
  end

  private

  def set_artwork
    @artwork = Artwork.find(params[:id])
  end

  def artwork_params
    params.require(:artwork).permit(
      :listing_name,
      :description,
      :height,
      :width,
      :depth,
      :year,
      :category,
      :medium,
      :price,
      :status,
      :is_framed,
      :subject,
      :images,
      style_ids: []
    )
  end

  def correct_user
    @artwork = current_user.artworks.find_by(id: params[:id])
    redirect_to root_url if @artwork.nil?
  end

  def stripe_ready
    if current_user.artworks.where(status:"For Sale").any? && current_user.stripe_user_id.nil?
      flash[:danger] = "Please connect with Stripe to accept payments."
    end
  end
end
