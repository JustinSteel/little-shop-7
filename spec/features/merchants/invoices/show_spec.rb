require "rails_helper"

RSpec.describe "Merchant Invoice Show", type: :feature do
  describe "When a user visits merchant's invoice show, there is information" do
    before(:each) do
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1)
      @customer_1 = create(:customer)

      @invoice_1 = create(:invoice, customer: @customer_1)
      create(:invoice_item, item: @item_1, invoice: @invoice_1)
      # create(:invoice_item, item: @item_2, invoice: @invoice_1)
    end

    it "They see invoice id, status, create date in format 'Monday, July 18, 2019'" do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      expect(page).to have_content("Invoice ##{@invoice_1.id}")
      expect(page).to have_content("Status: #{@invoice_1.status}")
      expect(page).to have_content("Created on: #{@invoice_1.formatted_date}")
    end

    it "They see customer first and last name" do
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      expect(page).to have_content("Customer: #{@invoice_1.customer_full_name}")
    end
  end
end