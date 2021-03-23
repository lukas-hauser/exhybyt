require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user           = users(:lukas)
    @space          = spaces(:one)
    @artwork        = artworks(:one)
    @inactive_space = spaces(:inactive_space)
  end

  test "Should redirect create when user not logged in" do
    assert_no_difference 'Reservation.count' do
      post space_reservations_path(@space), params: { reservation:
        { start_date: "2021-01-02 11:32:12",
          end_date: "2021-01-02 11:32:12",
          price: 1.5,
          total: 3.0} }
    end
    assert_redirected_to login_url
  end

  test "should redirect create when space is inactive" do
    log_in_as(@user)
    assert_no_difference 'Reservation.count' do
      post space_reservations_path(@inactive_space), params: { reservation:
        { start_date: "2021-01-02 11:32:12",
          end_date: "2021-01-02 11:32:12",
          price: 1.5,
          total: 3.0} }
    end
    assert_redirected_to root_url
    assert_not flash.empty?
  end
end
