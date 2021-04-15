require 'test_helper'

class SpaceTest < ActiveSupport::TestCase
  def setup
    @user = users(:lukas)
    @type = types(:one)
    @space = @user.spaces.build(
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
      user_id: @user.id,
      type_id: @type.id)
      @space.images.attach(
        io: File.open('app/assets/images/exhibition.jpg'),
        filename: 'exhibition.jpg')
  end

  test "should be valid" do
    assert @space.valid?
  end

  test "image should be present" do
    @space.images = nil
    assert_not @space.valid?
  end

  test "user id should be present" do
    @space.user_id = nil
    assert_not @space.valid?
  end

  test "type id should be present" do
    @space.type_id = nil
    assert_not @space.valid?
  end

  test "Listing name should be present" do
    @space.listing_name = "   "
    assert_not @space.valid?
  end

  test "Listing name should be no more than 60 characters " do
    @space.listing_name = "a" * 61
    assert_not @space.valid?
  end

  test "Description should be present" do
    @space.description = "   "
    assert_not @space.valid?
  end

  test "Description should be no more than 1000 characters " do
    @space.description = "a" * 1001
    assert_not @space.valid?
  end

  test "Category should be present" do
    @space.category = "   "
    assert_not @space.valid?
  end

  test "Address should be present" do
    @space.address = "   "
    assert_not @space.valid?
  end

  test "Wall Height should be present" do
    @space.wall_height = "   "
    assert_not @space.valid?
  end

  test "Wall Height should be greater than 0" do
    @space.wall_height = 0
    assert_not @space.valid?
    @space.wall_height = -1
    assert_not @space.valid?
  end

  test "Wall Width should be present" do
    @space.wall_width = "   "
    assert_not @space.valid?
  end

  test "Wall Width should be greater than 0" do
    @space.wall_width = 0
    assert_not @space.valid?
    @space.wall_width = -1
    assert_not @space.valid?
  end

  test "Price should be present" do
    @space.price = "   "
    assert_not @space.valid?
  end

  test "Price should be greater than or equal to 1" do
    @space.price = 0
    assert_not @space.valid?
    @space.price = 0.9
    assert_not @space.valid?
    @space.price = -1
    assert_not @space.valid?
  end

  test "Days Min should be present" do
    @space.days_min = "   "
    assert_not @space.valid?
  end

  test "Days Min should be greater than 0" do
    @space.days_min = 0
    assert_not @space.valid?
    @space.days_min = -1
    assert_not @space.valid?
  end

  test "order should be most recent listing first" do
    assert_equal spaces(:most_recent), Space.first
  end
end
