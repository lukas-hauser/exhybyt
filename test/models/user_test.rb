require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(firstname: "TestFirstName", lastname: "TestLastName",
    email: "test@example.com",
    password: "password123", password_confirmation: "password123")
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
    assert_not @user.authenticated?('')
  end

  test "associated spaces should be destroyed" do
    @user.save
    @user.spaces.create!(
      venue_type: "Coffee Shop",
      category: "Wall Space",
      listing_name: "Lukas' Cafe",
      description: "Cozy coffee shop in the town center",
      address: "Main Street 1, City 10000, UK",
      wall_height: "50.0",
      wall_width: "60.5",
      price: "25")
    assert_difference 'Space.count', -1 do
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
