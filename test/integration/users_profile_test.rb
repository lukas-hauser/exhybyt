require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:lukas)
  end

#  test "profile page" do
#    get user_path(@user)
#    assert_template 'users/show'
#    assert_select 'title', full_title(@user.firstname + " " + @user.lastname)
#    assert_select 'h1', text: @user.firstname + " " + @user.lastname
#    assert_select 'h1>img.gravatar'
#    assert_match @user.spaces.count.to_s, response.body
#  end
end
