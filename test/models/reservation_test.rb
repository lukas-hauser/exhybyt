# frozen_string_literal: true

require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  def setup
    @user    = users(:lukas)
    @space   = spaces(:three)
    @artwork = artworks(:one)
    @reservation = @user.reservations.build(
      start_date: 3.months.ago,
      end_date: 2.months.ago,
      price: '20',
      total: '100',
      space_id: @space.id,
      artwork_ids: @artwork.id,
      user_id: @user.id,
      currency: @space.user.currency
    )
  end

  test 'should be valid' do
    assert @reservation.valid?
  end

  test 'user id should be present' do
    @reservation.user_id = nil
    assert_not @reservation.valid?
  end

  test 'space id should be present' do
    @reservation.space_id = nil
    assert_not @reservation.valid?
  end

  test 'artwork id should be present' do
    @reservation.artwork_ids = nil
    assert_not @reservation.valid?
  end

  test 'Start date should be present' do
    @reservation.start_date = nil
    assert_not @reservation.valid?
  end

  test 'End date should be present' do
    @reservation.end_date = nil
    assert_not @reservation.valid?
  end

  test 'Price should be present' do
    @reservation.price = nil
    assert_not @reservation.valid?
  end

  test 'Total price should be present' do
    @reservation.total = nil
    assert_not @reservation.valid?
  end

#  test 'Price should be greater than or equal to 5' do
#    @reservation.price = 0
#    assert_not @reservation.valid?
#    @reservation.price = 4.9
#    assert_not @reservation.valid?
#    @reservation.price = -1
#    assert_not @reservation.valid?
#  end

#  test 'Total price should be greater than or equal to 5' do
#    @reservation.total = 0
#    assert_not @reservation.valid?
#    @reservation.total = 4.9
#    assert_not @reservation.valid?
#    @reservation.total = -1
#    assert_not @reservation.valid?
#  end

#  test 'Price can be 0 if space is for free' do
#    @reservation.space.for_free = true
#    @reservation.price = 0
#    assert @reservation.valid?
#  end

#  test 'Total price can be 0 if space is for free' do
#    @reservation.space.for_free = true
#    @reservation.total = 0
#    assert @reservation.valid?
#  end

  test 'end date should be after start date' do
    @reservation.start_date = 2.months.ago
    @reservation.end_date = 3.months.ago
    assert_not @reservation.valid?
  end

  test 'one-day-bookings are possible' do
    @reservation.start_date = Time.zone.today
    @reservation.end_date = Time.zone.today
    assert @reservation.valid?
  end

  test 'order should be most recent reservation first' do
    assert_equal reservations(:most_recent), Reservation.first
  end
end
