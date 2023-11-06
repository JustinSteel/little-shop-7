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
end