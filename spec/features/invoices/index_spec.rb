require "rails_helper"

RSpec.describe "Merchant Invoices Index", type: :feature do
  describe "When a user visits merchant's invoices index, there is information" do
    xit "They see all invoices with at least one of merchant's items" do
      visit merchant_invoices_path(@merchant1)

      expect(page).to have_content("My Invoices", count:1)
    end

    it "They see each invoice with its id that links the to the merchant invoice show page" do
    end
  end
  
end