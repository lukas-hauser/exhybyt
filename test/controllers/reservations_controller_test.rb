# frozen_string_literal: true

require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jane)
    @spaceuser = users(:lukas)
    @otheruser = users(:peter)
    @space = spaces(:one)
    @artwork = artworks(:one)
    @inactive_space = spaces(:inactive_space)
    @reservation = reservations(:one)
  end

  test 'should redirect show when user not logged in' do
    get reservations_path(@reservation)
    assert_not flash[:danger].empty?
    assert_redirected_to login_url
  end

  test 'should redirect show when wrong user' do
    log_in_as(@otheruser)
    get reservations_path(@reservation)
    #    assert_redirected_to root_url
    #    assert_not flash[:danger].empty?
  end

  test 'should redirect index when not logged in' do
    get reservations_path
    assert_not flash[:danger].empty?
    assert_redirected_to login_url
  end

  test 'should redirect your bookings when not logged in' do
    get your_bookings_path
    assert_not flash[:danger].empty?
    assert_redirected_to login_url
  end

  test 'should redirect your reservations when not logged in' do
    get your_reservations_path
    assert_not flash[:danger].empty?
    assert_redirected_to login_url
  end

  test 'should redirect payment when not logged in' do
    get reservation_payment_url(@reservation)
    assert_not flash[:danger].empty?
    assert_redirected_to login_url
  end

  test 'should redirect success when not logged in' do
    get reservation_success_url
    assert_not flash[:danger].empty?
    assert_redirected_to login_url
  end

  test 'should redirect cancel when not logged in' do
    get reservation_cancel_url
    assert_not flash[:danger].empty?
    assert_redirected_to login_url
  end

  test 'Should redirect create when user not logged in' do
    assert_no_difference 'Reservation.count' do
      post space_reservations_path(@space), params: { reservation:
        { start_date: '2021-01-02 11:32:12',
          end_date: '2021-01-02 11:32:12',
          artwork_ids: @artwork.id } }
    end
    assert_redirected_to login_url
  end

  test 'should redirect create when space is inactive' do
    log_in_as(@user)
    assert_no_difference 'Reservation.count' do
      post space_reservations_path(@inactive_space), params: { reservation:
        { start_date: '2021-01-02 11:32:12',
          end_date: '2021-01-02 11:32:12',
          artwork_ids: @artwork.id } }
    end
    assert_redirected_to root_url
    assert_not flash[:warning].empty?
  end

  test 'should redirect create when space user not stripe ready' do
    log_in_as(@user)
    @space.user.update(stripe_user_id: '')
    assert_no_difference 'Reservation.count' do
      post space_reservations_path(@space), params: { reservation:
        { start_date: Date.today,
          end_date: Date.today,
          artwork_ids: @artwork.id } }
    end
    assert_redirected_to root_url
    assert_not flash[:danger].empty?
  end

  test "don't allow reservation below minimum duration" do
    # tbd
  end

  test "Don't allow for multiple reservations for same time period from same user before approval/rejection" do
    # tbd
  end

  test "Don't allow users to submit other user's artworks" do
  end

  test "Don't allow users to book their own space" do
    log_in_as(@spaceuser)
    assert_no_difference 'Reservation.count' do
      post space_reservations_path(@space), params: { reservation:
        { start_date: Date.today,
          end_date: Date.today,
          artwork_ids: [@artwork.id] } }
    end
    assert_redirected_to root_url
    assert_not flash[:danger].empty?
  end
end
