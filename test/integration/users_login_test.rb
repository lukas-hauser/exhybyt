require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:lukas)
  end

  test "login with valid information/invalid password information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, password: 'invalid'} }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "log in with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "log in without remembering" do
    # Log in to set the cookie.
    log_in_as(@user, remember_me: '1')
    # Log in again and verify that the cookie is delted.
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password123'} }
    assert is_logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'html_pages/home'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", signup_path, count: 0
    assert_select "a[href=?]", new_password_reset_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", conversations_path
    assert_select "a[href=?]", artworks_path
    assert_select "a[href=?]", spaces_path
    assert_select "a[href=?]", your_bookings_path
    assert_select "a[href=?]", your_reservations_path
    assert_select "a[href=?]", new_artwork_path
    assert_select "a[href=?]", new_space_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", conversations_path, count: 0
    assert_select "a[href=?]", artworks_path, count: 0
    assert_select "a[href=?]", spaces_path, count: 0
    assert_select "a[href=?]", your_bookings_path, count: 0
    assert_select "a[href=?]", your_reservations_path, count: 0
    assert_select "a[href=?]", new_artwork_path, count: 0
    assert_select "a[href=?]", new_space_path, count: 0
    assert_select "a[href=?]", edit_user_path(@user), count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
