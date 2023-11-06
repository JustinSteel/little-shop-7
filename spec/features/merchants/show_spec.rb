require "rails_helper"

RSpec.describe "Merchant Dashboard" do
  it "has the merchant's name" do
    merchant = Merchant.create!(name: "Bob's Burgers", status: 1)
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    visit dashboard_merchant_path(merchant)
    # Then I see the name of my merchant
    expect(page).to have_content(merchant.name)
  end

  it "has a link to my merchant items index" do
    merchant = Merchant.create!(name: "Bob's Burgers", status: 1)
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    visit dashboard_merchant_path(merchant)
    # Then I see link to my merchant items index (/merchants/:merchant_id/items)
    expect(page).to have_link("#{merchant.name} Items")
    # And I see a link to my merchant invoices index (/merchants/:merchant_id/invoices)
    expect(page).to have_link("#{merchant.name} Invoices")
  end
end