require 'test_helper'

class HtmlPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get html_pages_home_url
    assert_response :success
  end

  test "should get help" do
    get html_pages_help_url
    assert_response :success
  end

  test "should get about" do
    get html_pages_about_url
    assert_response :success
  end

  test "should get howitworks" do
    get html_pages_howitworks_url
    assert_response :success
  end

  test "should get terms" do
    get html_pages_terms_url
    assert_response :success
  end

  test "should get privacypolicy" do
    get html_pages_privacypolicy_url
    assert_response :success
  end

  test "should get cookiepolicy" do
    get html_pages_cookiepolicy_url
    assert_response :success
  end

end
