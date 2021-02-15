require 'test_helper'

class MessageInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user =  users(:jane)
    @other = users(:lukas)
    @conversation = conversations(:one)
  end

  test "space interface" do
    log_in_as(@user)
    get root_path

    # Valid Submission Standard Way
    assert_difference 'Message.count', 1 do
      post conversation_messages_path(@conversation), params: { message:
        {content: "Hi!",
         user_id: @other.id } }
    end

    # Valid Submission with Ajax
    assert_difference 'Message.count', 1 do
      post conversation_messages_path(@conversation), xhr: true, params: { message:
        {content: "Hi!",
         user_id: @other.id } }
    end

    # Invalid Submission standard way
#    assert_no_difference 'Message.count' do
#      post conversation_messages_path(@conversation), params: { message:
#        {content: "a"*1001,
#        user_id: @other.id } }
#    end
#    assert_select 'div#error_explanation'

    # Invalid Submission with Ajax
#    assert_no_difference 'Message.count' do
#      post conversation_messages_path(@conversation), xhr: true, params: { message:
#        {content: "a"*1001,
#        user_id: @other.id } }
#    end
  end
end
