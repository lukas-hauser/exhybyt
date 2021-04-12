require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user               = users(:jane)
    @artwork            = artworks(:two)
    @artworkuser        = users(:lukas)
    @order              = orders(:one)
    @sold_art           = artworks(:sold)
    @not_for_sale_art   = artworks(:not_for_sale)
  end

  test "should redirect payment when not logged in" do
    get order_payment_url(@order.id)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect success when not logged in" do
    get order_success_url
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect cancel when not logged in" do
    get order_cancel_url
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "Should redirect create when user not logged in" do
    assert_no_difference 'Order.count' do
      post artwork_orders_path(@artwork)
    end
    assert_redirected_to login_url
  end

  test "should redirect create when artwork is sold or not for sale" do
    log_in_as(@user)
    assert_no_difference 'Order.count' do
      post artwork_orders_path(@sold_art)
    end
    assert_redirected_to root_url
    assert_not flash.empty?
    assert_no_difference 'Order.count' do
      post artwork_orders_path(@not_for_sale_art)
    end
    assert_redirected_to root_url
    assert_not flash.empty?
  end

  test "should redirect create when artist user not stripe ready" do
    log_in_as(@user)
    @artworkuser.update(stripe_user_id: "")
    assert_no_difference 'Order.count' do
      post artwork_orders_path(@artwork)
    end
    assert_redirected_to root_url
    assert_not flash.empty?
  end

  test "valid submission" do
    log_in_as(@user)
    assert_difference 'Order.count', 1 do
      post artwork_orders_path(@artwork)
    end
  end
end
