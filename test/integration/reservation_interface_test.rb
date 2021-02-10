require 'test_helper'

class ReservationInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jane)
    @space = spaces(:one)
    @artwork = artworks(:one)
  end

  test "space interface" do
    log_in_as(@user)
    get root_path

    # Invalid Submission
    assert_no_difference 'Reservation.count' do
      post space_reservations_path(@space), params: { reservation:
        { start_date: "2021-01-02 11:32:12",
          end_date: "2021-01-02 11:32:12",
          price: 1.5,
          total: ""} }
    end
    assert_not flash.empty?
    assert 'a[href=?]'

    # Valid Submission
    assert_difference 'Reservation.count', 1 do
      post space_reservations_path(@space), params: { reservation:
        { start_date: Date.today,
          end_date: Date.today,
          price: 1.5,
          total: 3.0,
          space_id: @space.id,
          artwork_ids: [@artwork.id],
          user_id: @user.id} }
    end
    follow_redirect!
    assert_template 'spaces/show'
  end
end
