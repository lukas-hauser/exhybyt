require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @message = messages(:one)
  end

  test "should redirect message when not logged in" do
    get conversation_messages_path(@message)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "Should redirect create message when user not logged in" do
    assert_no_difference "Message.count" do
      post conversation_messages_path(@message), params: {message:
        {content: "Hi"}}
    end
    assert_redirected_to login_url
  end

  test "Should redirect message when logged in as wrong user" do
    log_in_as(User.third)
    get conversation_messages_path(@message)
    assert_not flash.empty?
    assert_redirected_to conversations_path
  end
end
