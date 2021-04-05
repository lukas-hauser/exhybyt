require 'test_helper'

class ReservationApprovalsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user           = users(:lukas)
    @spaceuser      = users(:jane)
    @otheruser      = users(:peter)
    @space          = spaces(:one)
    @artwork        = artworks(:three)
    @inactive_space = spaces(:inactive_space)
    @reservation    = reservations(:one) # user: Lukas, Space provider: Jane
  end

  test "valid approval" do
    log_in_as(@spaceuser)
    get edit_reservation_approval_url(@reservation)
# => need valid payment intent id to get a successful approval.
#    assert_redirected_to @reservation
#    assert_not flash[:success].empty?
  end

  test "Should redirect edit when user not logged in" do
    get edit_reservation_approval_url(@reservation)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when wrong user tries to approve" do
    log_in_as(@otheruser)
    get edit_reservation_approval_url(@reservation)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "when incomplete reservation" do
  end

  test "when reservation has already been approved" do
  end

  test "when reservation has already been rejected" do
  end

  test "when booking request has already expired" do
  end

  test "don't let space user approve mutltiple reservations for same dates and same space." do
  end
end
