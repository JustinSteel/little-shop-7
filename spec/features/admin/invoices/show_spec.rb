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
        expect(page).to have_content("Customer: #{@invoice_1a.customer_name}")
        expect(page).to have_content("Status: #{@invoice_1a.status}")
      end
    end

    # US 34
    it "I see all of the items on the invoice including: item name, item quantity ordered, price item sold for, the invoice item status" do

      visit admin_invoice_path(@invoice_1a)

      within("#invoice_items-details") do
        within("#invoice_item-#{@invoice_items1.id}") do
          expect(page).to have_content(@invoice_items1.item.name)
          expect(page).to have_content("Quantity: #{@invoice_items1.quantity}")
          expect(page).to have_content("Unit Purchase Price: #{@invoice_items1.unit_price}")
          expect(page).to have_content("Status: #{@invoice_items1.status}")
          
          expect(page).to_not have_content(@invoice_items15.item.name)
        end
      end
    end

    # US 35
    it "I see the total revenue that will be generated from this invoice" do

      visit admin_invoice_path(@invoice_1a)

      within("#total-revenue") do
        expect(page).to have_content("Total Revenue: #{@invoice_1a.total_revenue}")
      end
    end
  end
end