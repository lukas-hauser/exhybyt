require 'test_helper'

class ArtworkInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jane)
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
        subject: "Portrait",
        styles: "Realism"} }
    end
    assert_select 'div#error_explanation'
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
        subject: "Portrait",
        styles: "Realism"} }
    end
    follow_redirect!
    assert_template 'artworks/show'

    # Delete Artwork
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'a', text: 'Delete'
    assert_select 'a', text: 'Edit'
    first_art = @user.artworks.paginate(page: 1).first
    assert_difference 'Artwork.count', -1 do
      delete artwork_path(first_art)
    end

    # Visit different user (no delete links)
    get user_path(users(:lukas))
    assert_template 'users/show'
    assert_select 'a', text: 'Delete', count: 0
    assert_select 'a', text: 'Edit', count: 0
  end
end
