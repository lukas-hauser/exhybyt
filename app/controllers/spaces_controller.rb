class SpacesController < ApplicationController
  before_action :set_space,       only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user,  except: [:show]
  before_action :correct_user, only: :destroy

  def index
#    @spaces = Space.all
    @spaces = current_user.spaces
  end

  def show
  end

  def new
    @space = current_user.spaces.build if logged_in?
  end

  def create
    @space = current_user.spaces.build(space_params)
    @space.images.attach(params[:space][:images])
    if @space.save
      flash[:success] = "Space saved."
      redirect_to @space
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @space.update(space_params)
      redirect_to @space
      flash[:success] = "updated."
    else
      render :edit
    end
  end

  def destroy
    @space.destroy
    flash[:success] = "Space has been deleted"
    redirect_to request.referrer || root_path
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
      :venue_type,
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
      :active
    )
  end

  def correct_user
    @space = current_user.spaces.find_by(id: params[:id])
    redirect_to root_url if @space.nil?
  end
end
