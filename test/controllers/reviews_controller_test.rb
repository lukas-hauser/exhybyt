require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @space  = spaces(:one)
    @review = reviews(:one)
    @user   = users(:lukas)
    @other_user = users(:jane)
  end

  test "Should redirect create when user not logged in" do
    assert_no_difference 'Review.count' do
      post space_reviews_path(@space), params: { review:
        { star: 3,
          comment: "This was so-so"
          } }
    end
    assert_redirected_to login_url
  end

#  test "Should redirect create if user didn't book the space" do
#    log_in_as(@other_user)
#    assert_no_difference 'Review.count' do
#      post space_reviews_path(@space), params: { review:
#        { star: 3,
#          comment: "This was so-so"
#          } }
#    end
#    assert_redirected_to root_url
#  end

#  test "Should redirect create if user already reviewed the space" do
#    log_in_as(@other_user)
#    assert_no_difference 'Review.count' do
#      post space_reviews_path(@space), params: { review:
#        { star: 3,
#          comment: "This was so-so"
#          } }
#    end
#    assert_redirected_to root_url
#  end

  test "Should redirect destroy when user not logged in" do
    assert_no_difference 'Review.count' do
      delete review_path(@review)
    end
    assert_redirected_to login_url
  end

  test "Should redirect destroy from wrong user" do
    log_in_as(@other_user)
    assert_no_difference 'Review.count' do
      delete review_path(@review)
    end
    assert_redirected_to root_url
  end
end
