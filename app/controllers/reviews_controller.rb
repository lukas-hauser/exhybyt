class ReviewsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user_create,   only: :create
  before_action :correct_user_destroy,  only: :destroy


  def create
    @review = current_user.reviews.create(review_params)
    redirect_to @review.space
  end

  def destroy
    @review = Review.find(params[:id])
    space = @review.space
    @review.destroy

    redirect_to space
  end

  private
    def review_params
      params.require(:review).permit(:comment, :star, :space_id)
    end

    def correct_user_create
      @space       = Space.find_by(id: params[:space_id])
      @reservation = Reservation.where("space_id = ? AND user_id = ?", @space.id, current_user.id)
      @review      = Review.find_by(user_id: current_user.id)
      redirect_to root_url if @reservation.nil?  || !@review.nil?
    end

    def correct_user_destroy
      @review = current_user.reviews.find_by(id: params[:id])
      redirect_to root_url if @review.nil?
    end
end
