require "rails_helper"

RSpec.describe "Admin Invoices Dashboard" do
  before :each do
    load_test_data
  end

  # US 32
  describe "As an admin, When I visit the admin invoice index (/admin/invoice)" do
    it "I see the id of each invoice in the system" do
      visit admin_invoices_path

      within("#invoice-#{@invoice_1a.id}") do
        expect(page).to have_content(@invoice_1a.id)
      end

      within("#invoice-#{@invoice_2a.id}") do
        expect(page).to have_content(@invoice_2a.id)
      end

      within("#invoice-#{@invoice_3a.id}") do
        expect(page).to have_content(@invoice_3a.id)
      end
    end
  end
end
