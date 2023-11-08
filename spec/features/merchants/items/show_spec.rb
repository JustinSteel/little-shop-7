require "rails_helper"

RSpec.describe "Merchant Item show page" do
  before(:each) do
    load_test_data
  end

  it "shows the item's info" do
    # 7. Merchant Items Show Page
    #
    # As a merchant,
    # When I click on the name of an item from the merchant items index page, (merchants/:merchant_id/items)
    # Then I am taken to that merchant's item's show page (/merchants/:merchant_id/items/:item_id)
    # And I see all of the item's attributes including:
    #
    # - Name
    # - Description
    # - Current Selling Price

    visit merchant_item_path(@merchant1, @item7)

    expect(page).to have_content @item7.name
    expect(page).to have_content "Description: #{@item7.description}"
    expect(page).to have_content "Price: #{@item7.unit_price}"
  end

  it "allows user to update the item information" do
    # 8. Merchant Item Update
    #
    # As a merchant,
    # When I visit the merchant show page of an item (/merchants/:merchant_id/items/:item_id)
    # I see a link to update the item information.
    # When I click the link
    # Then I am taken to a page to edit this item
    # And I see a form filled in with the existing item attribute information
    # When I update the information in the form and I click ‘submit’
    # Then I am redirected back to the item show page where I see the updated information
    # And I see a flash message stating that the information has been successfully updated.
    visit merchant_item_path(@merchant1, @item7)

    expect(page).to have_content "Price: #{@item7.unit_price}"

    click_link "Edit Item"

    fill_in "Price", with: 1000000
    click_button "Submit"

    expect(page).to have_current_path merchant_item_path(@merchant1, @item7)

    expect(page).to have_content "Price: 1000000"
  end

  it "handles a bad input" do
    visit edit_merchant_item_path(@merchant1, @item7)

    fill_in "Price", with: "AAA"
    click_button "Submit"

    expect(page).to have_css(".flash-message", text: "Invalid Field Input")
  end
end
