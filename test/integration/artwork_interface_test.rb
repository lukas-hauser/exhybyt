require 'test_helper'

class ArtworkInterfaceTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user      = users(:jane)
    @otheruser = users(:lukas)
    @style     = styles(:one)
    @subject   = subjects(:one)
    @artwork   = artworks(:three)
  end

  test "artwork interface" do
    log_in_as(@user)
    get root_path

    # Invalid Submission
    assert_no_difference 'Artwork.count' do
      post artworks_path, params: { artwork:
        {listing_name: "Moana Lisa",
        description: "",
        height: "60",
        width: "50",
        depth: "2.5",
        year: "2020",
        category: "Painting",
        medium: "Oil on Canvas",
        price: "5000",
        status: "For Sale",
        is_framed: true,
        subject_id: @subject.id,
        style_ids: [@style.id]} }
    end
    assert_select 'div#error_explanation'
    assert_select "title", "Add Art | EXHYBYT"
    assert 'a[href=?]'

    # Valid Submission
    assert_difference 'Artwork.count', 1 do
      post artworks_path, params: { artwork:
        {listing_name: "Moana Lisa",
        description: "This is the Hawaiian version of Mona Lisa",
        height: "60",
        width: "50",
        depth: "2.5",
        year: "2020",
        category: "Painting",
        medium: "Oil on Canvas",
        price: "5000",
        status: "For Sale",
        is_framed: true,
        subject_id: @subject.id,
        style_ids: [@style.id],
        images: fixture_file_upload("example.png", "image/png")} }
    end
    follow_redirect!
    assert_template 'artworks/show'

    # successful edit with friendly forwarding" do
    get user_path(@user)
    assert_template 'users/show'
    first_art = @user.artworks.paginate(page: 1).first
    get artwork_path(first_art)
    assert_template 'artworks/show'
    assert_select 'a', text: 'Edit'
    assert_select 'a', text: 'Delete'
    first_art = @user.artworks.paginate(page: 1).first
    get edit_artwork_path(first_art)
    assert_select "title", "Edit Artwork | EXHYBYT"
    listing_name = "Moana Lisa"
    description = "Aloha! This is the Hawaiian version of Mona Lisa."
    height = 60
    width = 50
    depth = 2.5
    year = 2020
    category = "Painting"
    medium = "Oil on Canvas"
    price = 5000
    status = "For Sale"
    is_framed = true
    subject_id = @subject.id
    style_ids = [@style.id]
    patch artwork_path(first_art), params: { artwork: { listing_name: listing_name,
      description: description,
      height: height,
      width: width,
      depth: depth,
      year: year,
      category: category,
      medium: medium,
      price: price,
      status: status,
      is_framed: is_framed,
      subject_id: @subject.id,
      style_ids: style_ids } }
    assert_not flash.empty?
    assert_redirected_to first_art
    first_art.reload
    assert_equal listing_name, first_art.listing_name
    assert_equal description,  first_art.description
    assert_equal category,     first_art.category
    assert_equal height,       first_art.height
    assert_equal width,        first_art.width
    assert_equal year,         first_art.year
    assert_equal depth,        first_art.depth
    assert_equal price,        first_art.price
    assert_equal medium,       first_art.medium
    assert_equal subject_id,   first_art.subject_id
    assert_equal status,       first_art.status
    assert_equal style_ids,    first_art.style_ids
    assert_equal is_framed,    first_art.is_framed

    # Delete Artwork
    assert_difference 'Artwork.count', -1 do
      delete artwork_path(first_art)
    end
    assert_redirected_to artworks_path

    # Visit artwork of different user (no delete and edit links)
    second_art = @otheruser.artworks.paginate(page: 1).first
    get artwork_path(second_art)
    assert_template 'artworks/show'
    assert_select 'a', text: 'Edit', count: 0
    assert_select 'a', text: 'Delete', count: 0
    assert_no_difference 'Artwork.count' do
      delete artwork_path(second_art)
    end
    assert_redirected_to root_url

    get edit_artwork_path(second_art)
    assert_redirected_to root_url

    patch artwork_path(second_art), params: { artwork: { listing_name: listing_name,
      description: description,
      height: height,
      width: width,
      depth: depth,
      year: year,
      category: category,
      medium: medium,
      price: price,
      status: status,
      is_framed: is_framed,
      subject_id: @subject.id,
      style_ids: style_ids } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "artwork show page" do
    get artwork_path(@artwork)
    assert_template 'artworks/show'
    assert_select 'title', full_title(@artwork.listing_name)
    assert_select 'h5', text: @artwork.listing_name
#    assert image
#    assert_select 'h2', text: @artwork.category + " by " + @artwork.user.display_name
#    assert_select 'p', text: 'Width: ' + @artwork.width.to_s + " cm | Height: " + @artwork.height.to_s + " cm"
#    assert_select 'p', text: @artwork.medium + " | " + @artwork.year.to_s
#    assert_select 'p', text: @artwork.depth
#    assert_select 'p', text: 'Price: £ ' + @artwork.price.to_s
#    assert_select 'p', text: @artwork.description
#    assert_select 'p', text: @artwork.subject
#    assert_select 'p', text: @artwork.status
#    assert_select 'p', text: @artwork.is_framed
#    assert_select 'h2', text: @artwork.styles
  end
end
