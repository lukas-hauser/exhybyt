require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase

  def setup
    @order = orders(:one)
  end

  test "Order Notification" do
    mail = OrderMailer.order_notification(@order)
    assert_equal "Someone bought your artwork!", mail.subject
    assert_equal [@order.artwork.user.email],    mail.to
    assert_equal ["hello@exhybyt.com"],          mail.from
    assert_match @order.artwork.user.firstname,  mail.body.encoded
  end

  test "Order Confirmation" do
    mail = OrderMailer.order_confirmation(@order)
    assert_equal "Order Confirmation",           mail.subject
    assert_equal [@order.user.email],            mail.to
    assert_equal ["hello@exhybyt.com"],          mail.from
    assert_match @order.user.firstname,          mail.body.encoded
  end

end
