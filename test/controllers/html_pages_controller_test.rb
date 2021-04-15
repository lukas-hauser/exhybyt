require 'test_helper'

class HtmlPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Home | EXHYBYT"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | EXHYBYT"
  end

  test "should get for businesses" do
    get for_businesses_path
    assert_response :success
    assert_select "title", "For Businesses | EXHYBYT"
  end

  test "should get for artists" do
    get for_artists_path
    assert_response :success
    assert_select "title", "For Artists | EXHYBYT"
  end

  test "should get for art lovers" do
    get for_art_lovers_path
    assert_response :success
    assert_select "title", "For Art Lovers | EXHYBYT"
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

  test "should get search" do
    get search_path
    assert_response :success
    assert_select "title", "Find Space | EXHYBYT"
  end

  test "should get browse art" do
    get art_path
    assert_response :success
    assert_select "title", "Art | EXHYBYT"
  end

  test "should get faq" do
    get faq_path
    assert_response :success
    assert_select "title", "FAQ | EXHYBYT"
  end

  test "should get dpa" do
    get dpa_path
    assert_response :success
    assert_select "title", "DPA | EXHYBYT"
  end

  test "should get how it works" do
    get howitworks_path
    assert_response :success
    assert_select "title", "How it works | EXHYBYT"
  end
end
