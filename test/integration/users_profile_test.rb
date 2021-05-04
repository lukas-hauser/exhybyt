require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:lukas)
  end

  test "profile page" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.display_name)
    assert_select 'h1', text: @user.display_name
    assert_select 'h1>img.gravatar'
    assert_match @user.spaces.count.to_s, response.body
    assert_match @user.artworks.count.to_s, response.body
#    assert_select 'div.pagination'
#    @user.spaces.paginate(page: 1).each do |space|
#      assert_match space.listing_name, response.body
#    end
#    @user.artworks.paginate(page: 1).each do |artwork|
#      assert_match artwork.listing_name, response.body
#    end
  end
end
