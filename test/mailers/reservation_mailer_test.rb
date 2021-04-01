require 'test_helper'

class ReservationMailerTest < ActionMailer::TestCase

  def setup
    @reservation = reservations(:one)
  end

  test "request_notification" do
    mail = ReservationMailer.request_notification(@reservation)
    assert_equal "New Booking Request",             mail.subject
    assert_equal [@reservation.space.user.email],   mail.to
    assert_equal ["hello@exhybyt.com"],             mail.from
    assert_match @reservation.space.user.firstname, mail.body.encoded
  end

  test "request_confirmation" do
    mail = ReservationMailer.request_confirmation(@reservation)
    assert_equal "Booking Request Submitted",  mail.subject
    assert_equal [@reservation.user.email],    mail.to
    assert_equal ["hello@exhybyt.com"],        mail.from
    assert_match @reservation.user.firstname,  mail.body.encoded
  end

  test "request_approval" do
    mail = ReservationMailer.request_approval(@reservation)
    assert_equal "Booking Request Approved",   mail.subject
    assert_equal [@reservation.user.email],    mail.to
    assert_equal ["hello@exhybyt.com"],        mail.from
    assert_match @reservation.user.firstname,  mail.body.encoded
  end

  test "request_rejection" do
    mail = ReservationMailer.request_rejection(@reservation)
    assert_equal "Booking Request Declined",   mail.subject
    assert_equal [@reservation.user.email],    mail.to
    assert_equal ["hello@exhybyt.com"],        mail.from
    assert_match @reservation.user.firstname,  mail.body.encoded
  end
end
