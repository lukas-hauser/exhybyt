require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:lukas)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { firstname: "", lastname: "", display_name: "" ,email: "lukas@example", password: "pass", password_confirmation: "word" } }
    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    firstname   = "James"
    lastname    = "Smith"
    displayname = "Jim"
    email       = "james@example.com"
    patch user_path(@user), params: { user: { firstname: firstname, lastname: lastname, display_name: displayname, email: email, password: "", password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal displayname, @user.display_name
    assert_equal firstname,   @user.firstname
    assert_equal lastname,    @user.lastname
    assert_equal email,       @user.email
  end
end
