require "rails_helper"

RSpec.describe "Merchant items index page" do
  before(:each) do
    load_test_data
  end

  it "shows all the items and none of them for other merchants" do
    # 6. Merchant Items Index Page
    #
    # As a merchant,
    # When I visit my merchant items index page (merchants/:merchant_id/items)
    # I see a list of the names of all of my items
    # And I do not see items for any other merchant
    visit merchant_items_path(@merchant1)

    within ".items" do
      @merchant1.items.each do |item|
        expect(page).to have_content item.name
      end
    end

    expect(page).to_not have_content create(:item).name  # weak test but test data has shared names for items
  end

  it "has a link to the item show page from the item name" do
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
    visit merchant_items_path(@merchant1)

    item = @merchant1.items.first
    click_on item.name

    expect(page).to have_current_path merchant_item_path(@merchant1, item)
  end

  it "has a button to disable/enable the item" do
    # 9. Merchant Item Disable/Enable
    #
    # As a merchant
    # When I visit my items index page (/merchants/:merchant_id/items)
    # Next to each item name I see a button to disable or enable that item.
    # When I click this button
    # Then I am redirected back to the items index
    # And I see that the items status has changed
    visit merchant_items_path(@merchant1)

    within("#item-#{@merchant1.items.first.id}") do
      expect(page).to have_button "Disable"
      click_button "Disable"
    end

    within("#item-#{@merchant1.items.first.id}") do
      expect(page).to have_button "Enable"
    end
  end
end