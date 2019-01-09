require 'test_helper'

class TimeCardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @time_card = time_cards(:one)
  end

  test "should get index" do
    get time_cards_url
    assert_response :success
  end

  test "should get new" do
    get new_time_card_url
    assert_response :success
  end

  test "should create time_card" do
    assert_difference('TimeCard.count') do
      post time_cards_url, params: { time_card: { client: @time_card.client, date: @time_card.date, description: @time_card.description, project: @time_card.project, tag: @time_card.tag, time: @time_card.time } }
    end

    assert_redirected_to time_card_url(TimeCard.last)
  end

  test "should show time_card" do
    get time_card_url(@time_card)
    assert_response :success
  end

  test "should get edit" do
    get edit_time_card_url(@time_card)
    assert_response :success
  end

  test "should update time_card" do
    patch time_card_url(@time_card), params: { time_card: { client: @time_card.client, date: @time_card.date, description: @time_card.description, project: @time_card.project, tag: @time_card.tag, time: @time_card.time } }
    assert_redirected_to time_card_url(@time_card)
  end

  test "should destroy time_card" do
    assert_difference('TimeCard.count', -1) do
      delete time_card_url(@time_card)
    end

    assert_redirected_to time_cards_url
  end
end
