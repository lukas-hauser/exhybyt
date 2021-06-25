# frozen_string_literal: true

require 'test_helper'

class ReservationInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user                 = users(:jane)
    @space                = spaces(:one)
    @artwork              = artworks(:one)
    @current_exhibition   = reservations(:current_exhibition)
    @one_day_exhibition   = reservations(:one_day_exhibition)
    @past_exhibition      = reservations(:past_exhibition)
    @upcoming_exhibition  = reservations(:upcoming_exhibition)
  end

  test 'reservation interface' do
    log_in_as(@user)
    get root_path

    # Invalid Submission
    assert_no_difference 'Reservation.count' do
      post space_reservations_path(@space), params: { reservation:
        { start_date: '2021-01-02 11:32:12',
          end_date: '2021-01-02 11:32:12',
          artwork_ids: [],
          user_id: @user.id } }
    end
    assert_not flash.empty?
    assert 'a[href=?]'

    # Valid Submission for free space
    assert_difference 'Reservation.count', 1 do
      @space.update_columns(for_free:true)
      post space_reservations_path(@space), params: { reservation:
        { start_date: Date.today,
          end_date: Date.today,
          space_id: @space.id,
          artwork_ids: [@artwork.id],
          user_id: @user.id } }
    end
    follow_redirect!
    assert_template 'reservations/show'
  end

  test 'exhibition interface' do
    # See only current_exhibition and one_day_exhibition
    get exhibitions_path
    assert_select 'title', 'Current Exhibitions | EXHYBYT'
    assert_select 'p',
                  text: @current_exhibition.start_date.strftime('%d %b %Y') + ' to ' + @current_exhibition.end_date.strftime('%d %b %Y')
    assert_select 'p',
                  text: @one_day_exhibition.start_date.strftime('%d %b %Y') + ' to ' + @one_day_exhibition.end_date.strftime('%d %b %Y')
    assert_select 'p',
                  text: @upcoming_exhibition.start_date.strftime('%d %b %Y') + ' to ' + @upcoming_exhibition.end_date.strftime('%d %b %Y'), count: 0
    assert_select 'p',
                  text: @past_exhibition.start_date.strftime('%d %b %Y') + ' to ' + @past_exhibition.end_date.strftime('%d %b %Y'), count: 0
    # See only upcoming_exhibition
    get upcoming_exhibitions_path
    assert_select 'title', 'Upcoming Exhibitions | EXHYBYT'
    assert_select 'p',
                  text: @current_exhibition.start_date.strftime('%d %b %Y') + ' to ' + @current_exhibition.end_date.strftime('%d %b %Y'), count: 0
    assert_select 'p',
                  text: @one_day_exhibition.start_date.strftime('%d %b %Y') + ' to ' + @one_day_exhibition.end_date.strftime('%d %b %Y'), count: 0
    assert_select 'p',
                  text: @upcoming_exhibition.start_date.strftime('%d %b %Y') + ' to ' + @upcoming_exhibition.end_date.strftime('%d %b %Y')
    assert_select 'p',
                  text: @past_exhibition.start_date.strftime('%d %b %Y') + ' to ' + @past_exhibition.end_date.strftime('%d %b %Y'), count: 0
    # See only past_exhibition
    get past_exhibitions_path
    assert_select 'title', 'Past Exhibitions | EXHYBYT'
    assert_select 'p',
                  text: @current_exhibition.start_date.strftime('%d %b %Y') + ' to ' + @current_exhibition.end_date.strftime('%d %b %Y'), count: 0
    assert_select 'p',
                  text: @one_day_exhibition.start_date.strftime('%d %b %Y') + ' to ' + @one_day_exhibition.end_date.strftime('%d %b %Y'), count: 0
    assert_select 'p',
                  text: @upcoming_exhibition.start_date.strftime('%d %b %Y') + ' to ' + @upcoming_exhibition.end_date.strftime('%d %b %Y'), count: 0
    assert_select 'p',
                  text: @past_exhibition.start_date.strftime('%d %b %Y') + ' to ' + @past_exhibition.end_date.strftime('%d %b %Y')
  end
end
