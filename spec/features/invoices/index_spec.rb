require "rails_helper"

RSpec.describe "Merchant Invoices Index", type: :feature do
  # As a merchant,
  # When I visit my merchant's invoices index (/merchants/:merchant_id/invoices)
  # Then I see all of the invoices that include at least one of my merchant's items
  # And for each invoice I see its id
  # And each id links to the merchant invoice show page
  describe "When a user visits merchant's invoices index, there is information" do
    xit "They see all invoices with at least one of merchant's items" do
      visit merchant_invoices_path(@merchant1)

      expect(page).to have_content("My Invoices", count:1)
    end
  end
end