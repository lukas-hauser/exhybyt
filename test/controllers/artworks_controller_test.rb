# frozen_string_literal: true

require 'test_helper'

class ArtworksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @artwork = artworks(:one)
  end

  test 'Should redirect create when user not logged in' do
    assert_no_difference 'Artwork.count' do
      post artworks_path, params: { artwork:
        { listing_name: 'Moana Lisa',
          description: 'This is the Hawaiian version of Mona Lisa',
          height: '60',
          width: '50',
          depth: '2.5',
          year: '2020',
          category: 'Painting',
          medium: 'Oil on Canvas',
          price: '5000',
          status: 'For Sale',
          is_framed: true,
          subject: 'Portrait',
          styles: 'Realism' } }
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when user not logged in' do
    assert_no_difference 'Artwork.count' do
      delete artwork_path(@artwork)
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy for wrong artwork' do
    log_in_as(users(:lukas))
    artwork = artworks(:three)
    assert_no_difference 'Artwork.count' do
      delete artwork_path(artwork)
    end
    assert_redirected_to root_url
  end

  test 'should redirect edit when not logged in' do
    get edit_artwork_path(@artwork)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect edit for wrong artwork' do
    log_in_as(users(:lukas))
    artwork = artworks(:three)
    get edit_artwork_path(artwork)
    assert_empty flash
    assert_redirected_to root_url
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as(users(:jane))
    patch artwork_path(@artwork), params: { artwork: { listing_name: 'Moana Lisa',
                                                       description: 'This is the Hawaiian version of Mona Lisa',
                                                       height: '60',
                                                       width: '50',
                                                       depth: '2.5',
                                                       year: '2020',
                                                       category: 'Painting',
                                                       medium: 'Oil on Canvas',
                                                       price: '5000',
                                                       status: 'For Sale',
                                                       is_framed: true,
                                                       subject: 'Portrait',
                                                       styles: 'Realism' } }
    assert_empty flash
    assert_redirected_to root_url
  end
end
