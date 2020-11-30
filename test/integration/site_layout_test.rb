require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'html_pages/home'
    assert_select "a[href=?]", "home"
#    assert_select "a[href=?]", "help"
    assert_select "a[href=?]", "about"
    assert_select "a[href=?]", "howitworks"
    assert_select "a[href=?]", "terms"
    assert_select "a[href=?]", "privacypolicy"
    assert_select "a[href=?]", "cookiepolicy"
    assert_select "a[href=?]", "contact"
  end
end
