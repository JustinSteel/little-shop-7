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

  end
end