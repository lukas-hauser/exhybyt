# frozen_string_literal: true

require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:lukas)
    #    @non_admin = users(:jane) can't be deleted as there are reservations?
    @non_admin = User.third
  end

  test 'index as admin including delete links' do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'title', 'Users | EXHYBYT'
    #   assert_select 'div.pagination'

    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.display_name
      assert_select 'a[href=?]', user_path(user), text: 'delete' unless user == @admin
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test 'index as non-admin' do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
