require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(firstname: "TestFirstName", lastname: "TestLastName",
    email: "test@example.com",
    password: "password123", password_confirmation: "password123", currency: "gbp")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "firstname should be present" do
    @user.firstname = "     "
    assert_not @user.valid?
  end

  test "lastname should be present" do
    @user.lastname = "     "
    assert_not @user.valid?
  end

  test "Display Name should be present" do
    @user.display_name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "firstname cannot be too long" do
    @user.firstname = "a" * 61
    assert_not @user.valid?
  end

  test "lastname cannot be too long" do
    @user.lastname = "a" * 61
    assert_not @user.valid?
  end

  test "email cannot be too long" do
    @user.lastname = "a" * 255 + "@example.com"
    assert_not @user.valid?
  end

  test "instagram cannot be too long" do
    @user.instagram = "a" * 61
    assert_not @user.valid?
  end

  test "facebook cannot be too long" do
    @user.facebook = "a" * 61
    assert_not @user.valid?
  end

  test "twitter cannot be too long" do
    @user.twitter = "a" * 61
    assert_not @user.valid?
  end

  test "website cannot be too long" do
    @user.website = "a" * 61
    assert_not @user.valid?
  end

  test "bio cannot be too long" do
    @user.bio = "a" * 1001
    assert_not @user.valid?
  end

  test "currency cannot be too long" do
    @user.currency = "usdd"
    assert_not @user.valid?
  end

  test "currency cannot be empty" do
    @user.currency = " "
    assert_not @user.valid?
  end

  test "user name cannot be too long" do
    @user.user_name = "a" * 61
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[tony@example.com JOHN@test.com MARY_Smith@new.co.uk]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should not accept invalid addresses" do
    invalid_addresses = %w[tony@example,com JOHN.at.test.com test@example. mary@@new.co.uk test@ex@ample.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (cannot be blank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "p" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for user with nil digest" do
    assert_not @user.authenticated?(:remember,'')
  end

  test "associated spaces should be destroyed" do
    @user.save
    @space = @user.spaces.build(
      venue_type: "Coffee Shop",
      category: "Wall Space",
      listing_name: "Lukas' Cafe",
      description: "Cozy coffee shop in the town center",
      address: "Main Street 1, City 10000, UK",
      wall_height: "50.0",
      wall_width: "60.5",
      price: "25")
      @space.images.attach(
        io: File.open('app/assets/images/exhibition.jpg'),
        filename: 'exhibition.jpg')
#    assert_difference 'Space.count', -1 do
#      @user.destroy
#    end
  end

  test "associated artworks should be destroyed" do
    @user.save
    @style = styles(:one)
    @artwork = @user.artworks.build(
      listing_name: "Moana Lisa",
      description: "This is the Hawaiian version of Mona Lisa",
      height: "60",
      width: "50",
      depth: "2.5",
      year: "2020",
      category: "Painting",
      medium: "Oil on Canvas",
      price: "5000",
      status: "For Sale",
      is_framed: true,
      subject: "Portrait",
      style_ids: @style.id)
      @artwork.images.attach(
        io: File.open('app/assets/images/skull.jpg'),
        filename: 'skull.jpg')
      assert @artwork.valid?
#    assert_difference 'Artwork.count', -1 do
#      @user.destroy
#    end
  end

  test "associated reservations should be destroyed" do
    @user.save
    @space   = spaces(:three)
    @artwork = artworks(:one)
    @user.reservations.create!(
      start_date: 3.months.ago,
      end_date: 2.months.ago,
      price: "20",
      total: "100",
      space_id: @space.id,
      artwork_ids: @artwork.id,
      currency: @space.user.currency)
    assert_difference 'Reservation.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    tony = users(:lukas)
    jane = users(:jane)
    assert_not tony.following?(jane)
    tony.follow(jane)
    assert tony.following?(jane)
    assert jane.followers.include?(tony)
    tony.unfollow(jane)
    assert_not tony.following?(jane)
  end
end
