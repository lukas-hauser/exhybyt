require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  def setup
    @user    = users(:lukas)
    @space   = spaces(:three)
    @artwork = artworks(:one)
    @reservation = @user.reservations.build(
      start_date: 3.months.ago,
      end_date: 2.months.ago,
      price: "20",
      total: "100",
      space_id: @space.id,
      artwork_ids: @artwork.id,
      user_id: @user.id,
      currency: @space.user.currency)
  end

  test "should be valid" do
    assert @reservation.valid?
  end

  test "user id should be present" do
    @reservation.user_id = nil
    assert_not @reservation.valid?
  end

  test "space id should be present" do
    @reservation.space_id = nil
    assert_not @reservation.valid?
  end

  test "artwork id should be present" do
    @reservation.artwork_ids = nil
    assert_not @reservation.valid?
  end

  test "Start date should be present" do
    @reservation.start_date = nil
    assert_not @reservation.valid?
  end

  test "End date should be present" do
    @reservation.end_date = nil
    assert_not @reservation.valid?
  end

  test "Price should be present" do
    @reservation.price = nil
    assert_not @reservation.valid?
  end

  test "Total price should be present" do
    @reservation.total = nil
    assert_not @reservation.valid?
  end

  test "end date should be after start date" do
    @reservation.start_date = 2.months.ago
    @reservation.end_date = 3.months.ago
    assert_not @reservation.valid?
  end

  test "one-day-bookings are possible" do
    @reservation.start_date = Date.today
    @reservation.end_date = Date.today
    assert @reservation.valid?
  end

  test "order should be most recent reservation first" do
    assert_equal reservations(:most_recent), Reservation.first
  end
end
