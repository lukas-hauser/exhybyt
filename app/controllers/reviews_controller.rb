class ReviewsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user_create,   only: [:create]
  before_action :completed_reservation, only: [:create]
  before_action :duplicate_review,      only: [:create]
  before_action :correct_user_destroy,  only: [:destroy]

  def create
    @review = current_user.reviews.build(review_params)
    @reservation = Reservation.find(params[:reservation_id])
    @review.reservation = @reservation
    @review.space = @reservation.space
    if @review.save
      flash[:success] = "Thank you for leaving a review!"
    else
      flash[:danger] = "Something went wrong."
    end
    redirect_to @reservation
  end

  def destroy
    @review = Review.find(params[:id])
    space = @review.space
    @review.destroy
    flash[:success] = "Your review has been deleted."
    redirect_to space
  end

  private

  def review_params
    params.require(:review).permit(:comment, :star)
  end

  # User can only review create review for paid reservations
  def completed_reservation
    @reservation = Reservation.find_by(id: params[:reservation_id])
    unless @reservation.payment_captured
      redirect_to @reservation
      flash[:danger] = "Can't review this reservation yet."
    end
  end

  # Only reservation user can leave a review
  def correct_user_create
    @reservation = Reservation.find_by(id: params[:reservation_id])
    redirect_to @reservation unless current_user?(@reservation.user)
  end

  # User can't leave more than 1 review per reservation
  def duplicate_review
    @reservation = Reservation.find_by(id: params[:reservation_id])
    if @reservation.reviews.any?
      redirect_to @reservation
      flash[:danger] = "You already left a review for this booking."
    end
  end

  def correct_user_destroy
    @review = current_user.reviews.find_by(id: params[:id])
    redirect_to root_url if @review.nil?
  end
end
