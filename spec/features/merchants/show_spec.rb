require "rails_helper"

RSpec.describe "Merchants dashboard page" do
  before(:each) do
    load_test_data
  end

  it "shows statistics for a favorite customers" do
    # 3. Merchant Dashboard Statistics - Favorite Customers
    #
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see the names of the top 5 customers
    # who have conducted the largest number of successful transactions with my merchant
    # And next to each customer name I see the number of successful transactions they have
    # conducted with my merchant
    visit dashboard_merchant_path

    within(".favorite-customers") do
      expect(page).to have_content @customer_1.first_name
    end
  end
end
