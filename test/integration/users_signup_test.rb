require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { firstname: " ", lastname: " ", email: "tony@example", password: "pass", password_confirmation: "word" }}
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { firstname: "Lukas", lastname: "Hauser", email: "lukas@example.com", password: "password123", password_confirmation: "password123" }}
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
