# frozen_string_literal: true

require 'test_helper'

class StyleTest < ActiveSupport::TestCase
  def setup
    @style = styles(:one)
  end

  test 'Artwork style should be valid' do
    assert @style.valid?
  end

  test 'name should be present' do
    @style.name = ''
    assert_not @style.valid?
  end

  test 'style should be unique' do
    @style.save
    @style2 = Style.new(name: 'Abstract')
    assert_not @style2.valid?
  end

  test 'name should not be too long' do
    @style.name = 'a' * 26
    assert_not @style.valid?
  end

  test 'name should not be too short' do
    @style.name = 'a' * 2
    assert_not @style.valid?
  end
end
