require "application_system_test_case"

class TimeCardsTest < ApplicationSystemTestCase
  setup do
    @time_card = time_cards(:one)
  end

  test "visiting the index" do
    visit time_cards_url
    assert_selector "h1", text: "Time Cards"
  end

  test "creating a Time card" do
    visit time_cards_url
    click_on "New Time Card"

    fill_in "Client", with: @time_card.client
    fill_in "Date", with: @time_card.date
    fill_in "Description", with: @time_card.description
    fill_in "Project", with: @time_card.project
    fill_in "Tag", with: @time_card.tag
    fill_in "Time", with: @time_card.time
    click_on "Create Time card"

    assert_text "Time card was successfully created"
    click_on "Back"
  end

  test "updating a Time card" do
    visit time_cards_url
    click_on "Edit", match: :first

    fill_in "Client", with: @time_card.client
    fill_in "Date", with: @time_card.date
    fill_in "Description", with: @time_card.description
    fill_in "Project", with: @time_card.project
    fill_in "Tag", with: @time_card.tag
    fill_in "Time", with: @time_card.time
    click_on "Update Time card"

    assert_text "Time card was successfully updated"
    click_on "Back"
  end

  test "destroying a Time card" do
    visit time_cards_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Time card was successfully destroyed"
  end
end
