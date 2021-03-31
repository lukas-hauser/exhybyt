require 'test_helper'

class SpaceInterfaceTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user =  users(:jane)
    @space = spaces(:one)
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
        active: true,
        images: fixture_file_upload("example.png", "image/png")} }
    end
    assert_select 'div#error_explanation'
    assert_select "title", "Add Space | EXHYBYT"
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
        active: true,
        images: fixture_file_upload("example.png", "image/png")} }
    end
    follow_redirect!
    assert_template 'spaces/show'

    # successful edit with friendly forwarding" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'a', text: 'Delete'
    assert_select 'a', text: 'Edit'
    first_space = @user.spaces.paginate(page: 1).first
    get edit_space_path(first_space)
    assert_select "title", "Edit Space | EXHYBYT"
    venue_type = "Coffee Shop"
    category = "Wall Space"
    listing_name = "Jane's Cafe"
    description = "Cozy coffee shop in the town center"
    address = "Main Street 1, City 10000, UK"
    wall_height = 50.0
    wall_width = 60.5
    price = 25
    patch space_path(first_space), params: { space: { venue_type: venue_type,
      category: category,
      listing_name: listing_name,
      description: description,
      address: address,
      wall_height: wall_height,
      wall_width: wall_width,
      price: price } }
    assert_not flash.empty?
    assert_redirected_to first_space
    first_space.reload
    assert_equal category,     first_space.category
    assert_equal listing_name, first_space.listing_name
    assert_equal description,  first_space.description
    assert_equal address,      first_space.address
    assert_equal wall_height,  first_space.wall_height
    assert_equal wall_width,   first_space.wall_width
    assert_equal price,        first_space.price

    # Delete Space
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'a', text: 'Delete'
    assert_select 'a', text: 'Edit'
    assert_difference 'Space.count', -1 do
      delete space_path(first_space)
    end

    # Visit different user (no delete links)
    get user_path(users(:lukas))
    assert_template 'users/show'
    assert_select 'a', text: 'Delete', count: 0
    assert_select 'a', text: 'Edit', count: 0
  end

  test "space show page" do
    get space_path(@space)
    assert_template 'spaces/show'
    assert_select 'title', full_title(@space.listing_name)
    assert_select 'h1', text: @space.listing_name
#   assert image
#    assert_select 'h2', text: @space.category
#    assert_select 'h2', text: @space.venue_type
#    assert_select 'p', text: 'Width: ' + @space.wall_width.to_s + " cm | Height: " + @space.wall_height.to_s + " cm"
#    assert_select 'p', text: 'Price: £ ' + @space.price.to_s + ' per day'
#    assert_select 'p', text: @space.description
#    assert_select 'p', text: @space.address

    # Don't show reservation form if logged in

    # Show reservation form if logged in
  end
end
