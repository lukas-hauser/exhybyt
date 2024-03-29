# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user,  only: %i[show index edit update destroy following followers]
  before_action :correct_user,    only: %i[edit update]
  before_action :admin_user,      only: %i[destroy index]

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @spaces = @user.spaces.where(active: true).paginate(page: params[:page])
    @artworks = @user.artworks.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated?
  end

  def new
    if logged_in?
      redirect_to root_url
      flash[:warning] = "You're already signed up and logged in."
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if verify_recaptcha(model: @user) && @user.save
      @user.send_activation_email
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :display_name, :email, :password,
                                 :password_confirmation, :instagram, :facebook, :twitter,
                                 :website, :bio, :marketing_consent, :currency, :image)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
