require "rails_helper"

RSpec.describe "Admin Invoices Show Page" do
  before :each do
    load_test_data
  end

  describe "As an admin, When I visit the admin invoices show page (/admin/invoices/:invoice_id)" do
    # US 33
    it "I see information related to that invoice including: id, status, created at, customer first and last name" do

      visit admin_invoice_path(@invoice_1a)

      expect(page).to have_content(@invoice_1a.id)
      within("#invoice-details") do
      expect(page).to have_content("Date Created: #{@invoice_1a.formatted_date}")
      expect(page).to have_content("Customer Name: #{@invoice_1a.customer_name}")
      expect(page).to have_content("Status: #{@invoice_1a.status}")
      end
    end
  end
end