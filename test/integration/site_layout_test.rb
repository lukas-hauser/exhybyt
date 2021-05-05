# frozen_string_literal: true

require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:lukas)
  end

  test 'layout links' do
    get root_path
    assert_template 'html_pages/home'
    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', howitworks_path
    assert_select 'a[href=?]', for_businesses_path
    assert_select 'a[href=?]', for_artists_path
    assert_select 'a[href=?]', for_art_lovers_path
    assert_select 'a[href=?]', faq_path
    assert_select 'a[href=?]', search_path
    assert_select 'a[href=?]', art_path
    assert_select 'a[href=?]', exhibitions_path
    assert_select 'a[href=?]', upcoming_exhibitions_path
    assert_select 'a[href=?]', terms_path
    assert_select 'a[href=?]', privacypolicy_path
    assert_select 'a[href=?]', cookiepolicy_path
    assert_select 'a[href=?]', contact_path

    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', signup_path

    assert_select 'a[href=?]', artworks_path,          count: 0
    assert_select 'a[href=?]', spaces_path,            count: 0
    assert_select 'a[href=?]', your_bookings_path,     count: 0
    assert_select 'a[href=?]', your_reservations_path, count: 0
    assert_select 'a[href=?]', new_artwork_path,       count: 0
    assert_select 'a[href=?]', new_space_path,         count: 0
    assert_select 'a[href=?]', user_path(@user),       count: 0
    assert_select 'a[href=?]', edit_user_path(@user),  count: 0
    assert_select 'a[href=?]', conversations_path,     count: 0

    log_in_as(@user)
    get root_path
    assert_select 'a[href=?]', artworks_path
    assert_select 'a[href=?]', spaces_path
    assert_select 'a[href=?]', your_bookings_path
    assert_select 'a[href=?]', your_reservations_path
    assert_select 'a[href=?]', new_artwork_path
    assert_select 'a[href=?]', new_space_path
    assert_select 'a[href=?]', conversations_path
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'a[href=?]', edit_user_path(@user)
  end
end
