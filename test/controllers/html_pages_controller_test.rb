require 'test_helper'

class HtmlPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Home | EXHYBYT"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | EXHYBYT"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | EXHYBYT"
  end

  test "should get howitworks" do
    get howitworks_path
    assert_response :success
    assert_select "title", "How it works | EXHYBYT"
  end

  test "should get terms" do
    get terms_path
    assert_response :success
    assert_select "title", "Terms of use | EXHYBYT"
  end

  test "should get privacypolicy" do
    get privacypolicy_path
    assert_response :success
    assert_select "title", "Privacy Policy | EXHYBYT"
  end

  test "should get cookiepolicy" do
    get cookiepolicy_path
    assert_response :success
    assert_select "title", "Cookie Policy | EXHYBYT"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | EXHYBYT"
  end

  test "should get signup" do
    get signup_path
    assert_response :success
    assert_select "title", "Sign Up | EXHYBYT"
  end

  test "should get login" do
    get login_path
    assert_response :success
    assert_select "title", "Log In | EXHYBYT"
  end

end
