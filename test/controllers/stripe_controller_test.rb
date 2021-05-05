# frozen_string_literal: true

require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:lukas)
    @other_user = users(:jane)
  end

  test 'should redirect stripe connect when not logged in' do
    get stripe_connect_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect stripe dashboard when not logged in' do
    get stripe_dashboard_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'Should redirect stripe dashboard when logged in as wrong user' do
    log_in_as(@other_user)
    get stripe_dashboard_path(@user)
    assert_empty flash
    assert_redirected_to root_url
  end

  test 'Should redirect stripe connect when logged in as wrong user' do
  end
end
