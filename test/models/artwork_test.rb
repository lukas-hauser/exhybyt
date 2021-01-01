require 'test_helper'

class ArtworkTest < ActiveSupport::TestCase
  def setup
    @user = users(:lukas)
    @artwork = @user.artworks.build(
      listing_name: "Moana Lisa",
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
      styles: "Realism",
      user_id: @user.id)
  end

  test "should be valid" do
    assert @artwork.valid?
  end

  test "user id should be present" do
    @artwork.user_id = nil
    assert_not @artwork.valid?
  end

  test "Listing name should be present" do
    @artwork.listing_name = "   "
    assert_not @artwork.valid?
  end

  test "Listing name should be no more than 60 characters " do
    @artwork.listing_name = "a" * 61
    assert_not @artwork.valid?
  end

  test "Description should be present" do
    @artwork.description = "   "
    assert_not @artwork.valid?
  end

  test "Description should be no more than 1000 characters " do
    @artwork.description = "a" * 1001
    assert_not @artwork.valid?
  end

  test "Medium should be present" do
    @artwork.medium = "   "
    assert_not @artwork.valid?
  end

  test "Category should be present" do
    @artwork.category = "   "
    assert_not @artwork.valid?
  end

  test "Height should be present" do
    @artwork.height = "   "
    assert_not @artwork.valid?
  end

  test "Width should be present" do
    @artwork.height = "   "
    assert_not @artwork.valid?
  end

  test "Price should be present" do
    @artwork.price = "   "
    assert_not @artwork.valid?
  end

  test "Status should be present" do
    @artwork.status = "   "
    assert_not @artwork.valid?
  end

  test "Year should be present" do
    @artwork.year = "   "
    assert_not @artwork.valid?
  end

  test "Subject should be present" do
    @artwork.subject = "   "
    assert_not @artwork.valid?
  end

  test "Styles should be present" do
    @artwork.styles = "   "
    assert_not @artwork.valid?
  end

  test "order should be most recent listing first" do
    assert_equal spaces(:most_recent), Space.first
  end
end
