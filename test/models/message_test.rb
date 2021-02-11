require "test_helper"

class MessageTest < ActiveSupport::TestCase
  def setup
    @message = messages(:one)
  end

  test "Message should be valid" do
    assert @message.valid?
  end

  test "Content should be present" do
    @message.content = " "
    assert_not @message.valid?
  end

  test "user id should be present" do
    @message.user_id = nil
    assert_not @message.valid?
  end

  test "Conversation id should be present" do
    @message.conversation_id = nil
    assert_not @message.valid?
  end

  test "Content should be no more than 1000 characters " do
    @message.content = "a" * 1001
    assert_not @message.valid?
  end

  test "order should be most recent message first" do
    assert_equal messages(:most_recent), Message.first
  end
end
