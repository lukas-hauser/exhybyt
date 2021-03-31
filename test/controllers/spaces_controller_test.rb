require 'test_helper'

class SpacesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @space = spaces(:one)
  end

  test "Should redirect create when user not logged in" do
    assert_no_difference 'Space.count' do
      post spaces_path, params: { space:
        {venue_type: "Coffee Shop",
        category: "Wall Space",
        listing_name: "Lukas' Cafe",
        description: "Cozy coffee shop in the town center",
        address: "Main Street 1, City 10000, UK",
        wall_height: "50.0",
        wall_width: "60.5",
        price: "25",
        days_min: "5",
        is_adj_light: true,
        is_nat_light: false,
        is_dis_acc: false,
        is_parking: false,
        is_hang_sys: false,
        is_plugs: true,
        is_sec_sys: false,
        is_toilet: true,
        is_wifi: false,
        is_storage: false,
        is_paintings: false,
        is_photography: false,
        is_drawings: false,
        is_sculptures: false,
        is_live_perf: false,
        is_adverts: false,
        active: true} }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when user not logged in" do
    assert_no_difference 'Space.count' do
      delete space_path(@space)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong space" do
    log_in_as (users(:lukas))
    space = spaces(:three)
    assert_no_difference 'Space.count' do
      delete space_path(space)
    end
    assert_redirected_to root_url
  end

  test "should redirect edit when not logged in" do
    get edit_space_path(@space)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit for wrong space" do
    log_in_as (users(:lukas))
    space = spaces(:three)
    get edit_space_path(space)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as (users(:jane))
    patch space_path(@space), params: { space: { venue_type: "Coffee Shop",
      category: "Wall Space",
      listing_name: "Jane's Cafe",
      description: "Cozy coffee shop in the town center",
      address: "Main Street 1, City 10000, UK",
      wall_height: "50.0",
      wall_width: "60.5",
      price: "25",
      days_min: "30" } }
    assert flash.empty?
    assert_redirected_to root_url
  end
end
