class ArtworksController < ApplicationController
  before_action :set_artwork,       only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user,  except: [:show]
  before_action :correct_user,      only: [:edit, :update, :destroy]

  def index
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
    redirect_to artworks_path
  end

  def delete_image_attachment
    @image = ActiveStorage::Blob.find_signed(params[:id])
    @artwork = Artwork.find_by(id: @image.attachments.first.record_id)
    @image.attachments.first.purge
    respond_to do |format|
      format.js
      format.html { redirect_to edit_artwork_path(@artwork) }
    end
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
      :subject_id,
      :images,
      style_ids: []
    )
  end

  def correct_user
    @artwork = current_user.artworks.find_by(id: params[:id])
    redirect_to root_url if @artwork.nil?
  end
end
