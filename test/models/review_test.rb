# frozen_string_literal: true

require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  def setup
    @review = reviews(:one)
  end

  test 'Review should be valid' do
    assert @review.valid?
  end

  test 'Star should be present' do
    @review.star = ' '
    assert_not @review.valid?
  end

  test 'Star should be a positive number up to 5' do
    @review.star = -5
    assert_not @review.valid?
    @review.star = 0
    assert_not @review.valid?
    @review.star = 6
    assert_not @review.valid?
  end

  test 'Comment should be present' do
    @review.comment = ' '
    assert_not @review.valid?
  end

  test 'User id should be present' do
    @review.user_id = nil
    assert_not @review.valid?
  end

  test 'Reservation id should be present' do
    @review.reservation_id = nil
    assert_not @review.valid?
  end

  test 'Space id should be present' do
    @review.space_id = nil
    assert_not @review.valid?
  end

  test 'Content should be no more than 1000 characters ' do
    @review.comment = 'a' * 1001
    assert_not @review.valid?
  end

  test 'order should be most recent message first' do
    assert_equal reviews(:most_recent), Review.first
  end
end
