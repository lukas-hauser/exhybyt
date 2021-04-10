require "test_helper"

class OrderTest < ActiveSupport::TestCase
  def setup
    @user    = users(:lukas)
    @artwork = artworks(:one)
    @order = @user.orders.build(
      price: "80",
      total: "100",
      delivery_fee: "20",
      artwork_id: @artwork.id,
      user_id: @user.id,
      currency: @artwork.user.currency)
  end

  test "should be valid" do
    assert @order.valid?
  end

  test "user id should be present" do
    @order.user_id = nil
    assert_not @order.valid?
  end

  test "artwork id should be present" do
    @order.artwork_id = nil
    assert_not @order.valid?
  end

  test "Price should be present" do
    @order.price = nil
    assert_not @order.valid?
  end

  test "Delivery Fee should be present" do
    @order.delivery_fee = nil
    assert_not @order.valid?
  end

  test "Total price should be present" do
    @order.total = nil
    assert_not @order.valid?
  end

  test "currency should be present" do
    @order.currency = nil
    assert_not @order.valid?
  end

  test "order should be most recent order first" do
    assert_equal orders(:most_recent), Order.first
  end
end
