# frozen_string_literal: true

class SpacesController < ApplicationController
  before_action :set_space, only: %i[show edit update destroy]
  before_action :logged_in_user, except: [:show]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    #    @spaces = Space.all
    @spaces = current_user.spaces.paginate(page: params[:page])
  end

  def show
    @booked = Reservation.where('space_id = ? AND user_id = ?', @space.id, current_user.id).present? if current_user
    @reviews = @space.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def new
    @space = current_user.spaces.build if logged_in?
  end

  def create
    @space = current_user.spaces.build(space_params)
    @space.images.attach(params[:space][:images])
    if @space.save
      if @space.for_free?
        @space.update_columns(price:0)
      end
      flash[:success] = 'Space saved.'
      redirect_to @space
    else
      render :new
    end
  end

  def edit; end

  def update
    @space.images.attach(params[:space][:images]) unless params[:space][:images].nil?
    if @space.update(space_params)
      if @space.for_free?
        @space.update_columns(price:0)
      end
      redirect_to @space
      flash[:primary] = 'Space updated.'
    else
      render :edit
    end
  end

  def destroy
    if @space.reservations.any?
      flash[:warning] =
        "Space currently can't be deleted as there are reservations. However, you can inactivate it, so it's not searchable and bookable anymore."
    else
      @space.destroy
      flash[:primary] = 'Space has been deleted'
    end
    redirect_to spaces_path
  end

  def delete_image_attachment
    @image = ActiveStorage::Blob.find_signed(params[:id])
    @space = Space.find_by(id: @image.attachments.first.record_id)
    @image.attachments.first.purge
    respond_to do |format|
      format.js
      format.html { redirect_to edit_space_path(@space) }
    end
  end

  private

  def set_space
    @space = Space.find(params[:id])
  end

  def space_params
    params.require(:space).permit(
      :listing_name,
      :address,
      :description,
      :category,
      :wall_height,
      :wall_width,
      :price,
      :is_adj_light,
      :is_dis_acc,
      :is_parking,
      :is_hang_sys,
      :is_storage,
      :is_wifi,
      :is_nat_light,
      :is_sec_sys,
      :is_toilet,
      :is_plugs,
      :is_paintings,
      :is_photography,
      :is_drawings,
      :is_sculptures,
      :is_live_perf,
      :is_adverts,
      :images,
      :active,
      :days_min,
      :type_id,
      :instagram,
      :facebook,
      :website,
      :twitter,
      :for_free,
      schedules_attributes: %i[
        id
        opens_at
        closes_at
        weekday
        _destroy
      ]
    )
  end

  def correct_user
    @space = current_user.spaces.find_by(id: params[:id])
    redirect_to root_url if @space.nil?
  end
end
