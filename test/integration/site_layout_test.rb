require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'html_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", for_businesses_path
    assert_select "a[href=?]", for_artists_path
    assert_select "a[href=?]", faq_path
    assert_select "a[href=?]", search_path
    assert_select "a[href=?]", art_path
    assert_select "a[href=?]", exhibitions_path
    assert_select "a[href=?]", terms_path
    assert_select "a[href=?]", privacypolicy_path
    assert_select "a[href=?]", cookiepolicy_path
    assert_select "a[href=?]", contact_path
  end
end
