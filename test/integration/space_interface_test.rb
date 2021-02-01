require 'test_helper'

class SpaceInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jane)
  end

  test "space interface" do
    log_in_as(@user)
    get root_path

    # Invalid Submission
    assert_no_difference 'Space.count' do
      post spaces_path, params: { space:
        {venue_type: "Coffee Shop",
        category: "Wall Space",
        listing_name: "Lukas' Cafe",
        description: "",
        address: "Main Street 1, City 10000, UK",
        wall_height: "50.0",
        wall_width: "60.5",
        price: "25",
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
    assert_select 'div#error_explanation'
    assert 'a[href=?]'

    # Valid Submission
    assert_difference 'Space.count', 1 do
      post spaces_path, params: { space:
        {venue_type: "Coffee Shop",
        category: "Wall Space",
        listing_name: "Lukas' Cafe",
        description: "Cozy coffee shop in the town center",
        address: "Main Street 1, City 10000, UK",
        wall_height: "50.0",
        wall_width: "60.5",
        price: "25",
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
    follow_redirect!
    assert_template 'spaces/show'

    # Delete Space
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'a', text: 'Delete'
    assert_select 'a', text: 'Edit'
    first_space = @user.spaces.paginate(page: 1).first
    assert_difference 'Space.count', -1 do
      delete space_path(first_space)
    end

    # Visit different user (no delete links)
    get user_path(users(:lukas))
    assert_template 'users/show'
    assert_select 'a', text: 'Delete', count: 0
    assert_select 'a', text: 'Edit', count: 0
  end
end
