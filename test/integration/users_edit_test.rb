require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:lukas)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { firstname: "", lastname: "", display_name: "" ,
                                              email: "lukas@example", password: "pass",
                                              password_confirmation: "word" } }
    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    firstname         = "James"
    lastname          = "Smith"
    displayname       = "Jim"
    email             = "james@example.com"
    currency          = "eur"
    marketing_consent =  false
    instagram         = "jamessmith_123"
    facebook          = "james.smith"
    twitter           = "james_smith"
    website           = "www.jamessmith.exhybyt.com"
    bio               = "Hi, this is James Smith"
#    user_name         = "jamessmith123"
    patch user_path(@user), params: { user: { firstname: firstname, lastname: lastname, display_name: displayname,
                                              email: email, currency: currency, password: "", password_confirmation: "",
                                              marketing_consent: marketing_consent, instagram: instagram, facebook: facebook,
                                              twitter: twitter, website: website, bio: bio } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal displayname,       @user.display_name
    assert_equal firstname,         @user.firstname
    assert_equal lastname,          @user.lastname
    assert_equal email,             @user.email
    assert_equal currency,          @user.currency
    assert_equal marketing_consent, @user.marketing_consent
    assert_equal instagram,         @user.instagram
    assert_equal facebook,          @user.facebook
    assert_equal twitter,           @user.twitter
    assert_equal website,           @user.website
    assert_equal bio,               @user.bio
#    assert_equal user_name,         @user.user_name
  end
end
