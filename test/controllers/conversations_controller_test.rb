require "test_helper"

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @conversation = conversations(:one)
  end

  test "should redirect conversation when not logged in" do
    get conversations_path(@conversation)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "Should redirect create message when user not logged in" do
    assert_no_difference "Message.count" do
      post conversations_path(@conversation), params: {conversation:
        {sender_id: 1,
         recipient_id: 2}}
    end
    assert_redirected_to login_url
  end
end
