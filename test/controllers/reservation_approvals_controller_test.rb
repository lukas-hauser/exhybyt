require 'test_helper'

class ReservationApprovalsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user           = users(:jane)
    @spaceuser      = users(:lukas)
    @otheruser      = users(:peter)
    @space          = spaces(:one)
    @artwork        = artworks(:three)
    @inactive_space = spaces(:inactive_space)
    @reservation    = reservations(:one) # user: Lukas, Space provider: Jane
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

  test "when reservation has already been approved" do
  end

  test "when reservation has already been rejected" do
  end
end
