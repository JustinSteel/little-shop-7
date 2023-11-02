require "rails_helper"

RSpec.describe "Merchant Dashboard" do
  it "has the merchant's name" do
    merchant = Merchant.create!(name: "Bob's Burgers", status: 1)
    # US 1
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    visit dashboard_merchant_path(merchant)
    # Then I see the name of my merchant
    expect(page).to have_content(merchant.name)
  end
end
