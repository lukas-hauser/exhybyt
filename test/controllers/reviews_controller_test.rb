# frozen_string_literal: true

require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @space = spaces(:one)
    @review = reviews(:one)
    @reservation = reservations(:one)
    @reservation.update(payment_captured: true)
    @user = users(:lukas)
    @other_user = users(:jane)
  end

  test 'Should redirect create when user not logged in' do
    @review.destroy # destroy so there is no existing review
    assert_no_difference 'Review.count' do
      post reservation_reviews_path(@reservation), params: { review:
        { star: 3,
          comment: 'This was so-so' } }
    end
    assert_redirected_to login_url
  end

  test "Should redirect create if user didn't book the space" do
    @review.destroy # destroy so there is no existing review
    log_in_as(@other_user)
    assert_no_difference 'Review.count' do
      post reservation_reviews_path(@reservation), params: { review:
        { star: 3,
          comment: 'This was so-so' } }
    end
    assert_redirected_to @reservation
  end

  test 'Should redirect create if reservation incomplete' do
    @review.destroy # destroy so there is no existing review
    @reservation.update(payment_captured: false)
    log_in_as(@user)
    assert_no_difference 'Review.count' do
      post reservation_reviews_path(@reservation), params: { review:
        { star: 3,
          comment: 'This was so-so' } }
    end
    assert_redirected_to @reservation
  end

  test 'Should redirect create if user already reviewed the space' do
    log_in_as(@user)
    assert_no_difference 'Review.count' do
      post reservation_reviews_path(@reservation), params: { review:
        { star: 3,
          comment: 'This was so-so' } }
    end
    assert_redirected_to @reservation
  end

  test 'Should redirect destroy when user not logged in' do
    assert_no_difference 'Review.count' do
      delete review_path(@review)
    end
    assert_redirected_to login_url
  end

  test 'Should redirect destroy from wrong user' do
    log_in_as(@other_user)
    assert_no_difference 'Review.count' do
      delete review_path(@review)
    end
    assert_redirected_to root_url
  end

  test 'Valid destroy and create review' do
    log_in_as(@user)
    assert_difference 'Review.count', - 1 do
      delete review_path(@review)
    end
    assert_difference 'Review.count', 1 do
      post reservation_reviews_path(@reservation), params: { review:
        { star: 3,
          comment: 'This was so-so' } }
    end
    assert_redirected_to @reservation
  end
end
