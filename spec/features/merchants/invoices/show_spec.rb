require "rails_helper"

RSpec.describe "Merchant Invoice Show", type: :feature do
  describe "When a user visits merchant's invoice show, there is information" do
    before(:each) do
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)
      @customer_1 = create(:customer)

      @invoice_1 = create(:invoice, customer: @customer_1)
      create(:invoice_item, item: @item_1, invoice: @invoice_1)
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

  describe "When a user visits merchant's invoice show, there is item information" do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1a = create(:item, merchant: @merchant_1)
      @item_1b = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_2)
      @customer_1 = create(:customer)

      @invoice_1 = create(:invoice, customer: @customer_1)
      @invoice_2 = create(:invoice, customer: @customer_1)
      create(:invoice_item, item: @item_1a, invoice: @invoice_1)
      create(:invoice_item, item: @item_1b, invoice: @invoice_1)
      create(:invoice_item, item: @item_2, invoice: @invoice_2)

      visit merchant_invoice_path(@merchant_1, @invoice_1)
    end

    it "They see a table: item name, quantity of item ordered, price item sold for, item status" do
      expect(page).to have_css('table')
      within :table, "ItemTable" do
        expect(page).to have_content("Item Name")
        expect(page).to have_content("Quantity")
        expect(page).to have_content("Unit Price")
        expect(page).to have_content("Status")

        expect(page).to have_content(@item_1a.name)
        expect(page).to have_content(@item_1a.unit_price)
        expect(page).to have_content(@item_1a.status_on_invoice)
        expect(page).to have_content(@item_1a.quantity_on_invoice)
        
        expect(page).to have_content(@item_1b.name)
        expect(page).to have_content(@item_1b.unit_price)
        expect(page).to have_content(@item_1b.status_on_invoice)
        expect(page).to have_content(@item_1b.quantity_on_invoice)
      end
    end

    xit "They do not see any information related to items from another merchant" do
      expect(page).to_not have_content("Customer: #{@invoice_2.item_name}")
    end
  end
end