require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:lukas)
    @other_user = users(:jane)
  end

  test "should redirect stripe connect when not logged in" do
    get stripe_connect_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "Should redirect stripe connect when user not logged in" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end
end
