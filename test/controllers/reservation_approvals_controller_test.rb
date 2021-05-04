require "test_helper"

class ReservationApprovalsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:lukas)
    @spaceuser = users(:jane)
    @otheruser = users(:peter)
    @space = spaces(:three)
    @artwork = artworks(:one)
    @reservation = @user.reservations.build(
      start_date: 1.month.from_now,
      end_date: 2.months.from_now,
      price: "20",
      total: "100",
      space_id: @space.id,
      artwork_ids: @artwork.id,
      user_id: @user.id,
      currency: @space.user.currency,
      created_at: 1.day.ago,
      payment_completed: true
    )
    @reservation.save
  end

  test "should be valid" do
    assert @reservation.valid?
  end

  test "valid approval" do
    #    log_in_as(@spaceuser)
    #    get edit_reservation_approval_url(@reservation)
    # => need valid payment intent id to get a successful approval.
    #    assert_redirected_to @reservation
    #    assert_not flash[:success].empty?
  end

  test "Should redirect edit when user not logged in" do
    get edit_reservation_approval_url(@reservation)
    assert_not flash[:danger].empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when wrong user tries to approve" do
    log_in_as(@otheruser)
    get edit_reservation_approval_url(@reservation)
    assert_not flash[:danger].empty?
    assert_redirected_to root_url
  end

  test "when incomplete booking request" do
    @reservation.update(payment_completed: false)
    log_in_as(@spaceuser)
    get edit_reservation_approval_url(@reservation)
    assert_not flash[:danger].empty?
    assert_redirected_to your_reservations_path
  end

  test "when reservation has already been rejected" do
    @reservation.update(rejected: true)
    log_in_as(@spaceuser)
    get edit_reservation_approval_url(@reservation)
    assert_not flash[:danger].empty?
    assert_redirected_to @reservation
  end

  test "when reservation has already been approved" do
    @reservation.update(approved: true)
    log_in_as(@spaceuser)
    get edit_reservation_approval_url(@reservation)
    #  assert_not flash[:warning].empty?
    #  assert_redirected_to @reservation
  end

  test "when booking request has already expired" do
    @reservation.update(created_at: 3.day.ago)
    log_in_as(@spaceuser)
    get edit_reservation_approval_url(@reservation)
    assert_not flash[:danger].empty?
    assert_redirected_to your_reservations_path
  end

  test "when payment intent was cancelled" do
    @reservation.update(status: "Payment Intent Cancelled")
    log_in_as(@spaceuser)
    get edit_reservation_approval_url(@reservation)
    assert_not flash[:danger].empty?
    assert_redirected_to @reservation
  end

  test "don't let space user approve mutltiple reservations for same dates and same space." do
  end
end
