require "rails_helper"

RSpec.describe "Merchant Invoice Show", type: :feature do
  describe "When a user visits merchant's invoice show, there is information" do
    # 15. Merchant Invoice Show Page
    #
    # As a merchant
    # When I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # Then I see information related to that invoice including:
    # - Invoice id
    # - Invoice status
    # - Invoice created_at date in the format "Monday, July 18, 2019"
    # - Customer first and last name
    before(:each) do
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)
      @customer_1 = create(:customer)

      @invoice_1 = create(:invoice, customer: @customer_1)
      create(:invoice_item, item: @item_1, invoice: @invoice_1)

      visit merchant_invoice_path(@merchant_1, @invoice_1)
    end

    it "They see invoice id, status, create date in format 'Monday, July 18, 2019'" do
      expect(page).to have_content("Invoice ##{@invoice_1.id}")
      expect(page).to have_content("Status: #{@invoice_1.status}")
      expect(page).to have_content("Created on: #{@invoice_1.created_at.to_formatted_s(:merchants)}")
    end

    it "They see customer first and last name" do
      expect(page).to have_content("Customer: #{@invoice_1.customer_full_name}")
    end
  end

  describe "When a user visits merchant's invoice show, there is item information" do
    # 16. Merchant Invoice Show Page: Invoice Item Information
    #
    # As a merchant
    # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # Then I see all of my items on the invoice including:
    # - Item name
    # - The quantity of the item ordered
    # - The price the Item sold for
    # - The Invoice Item status
    # And I do not see any information related to Items for other merchants
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1a = create(:item, merchant: @merchant_1)
      @item_1b = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_2)
      @customer_1 = create(:customer)

      @invoice_1 = create(:invoice, customer: @customer_1)
      @invoice_2 = create(:invoice, customer: @customer_1)
      @invoice_item_1a = create(:invoice_item, item: @item_1a, invoice: @invoice_1)
      @invoice_item_1b = create(:invoice_item, item: @item_1b, invoice: @invoice_1)
      create(:invoice_item, item: @item_2, invoice: @invoice_2)

      visit merchant_invoice_path(@merchant_1, @invoice_1)
    end

    it "They see a table: item name, quantity of item ordered, price item sold for, item status" do
      expect(page).to have_content("Items on this Invoice:")
      expect(page).to have_css("table")

      within :table, "ItemTable" do
        expect(page).to have_content("Item Name")
        expect(page).to have_content("Quantity")
        expect(page).to have_content("Unit Price")
        expect(page).to have_content("Status")

        expect(page).to have_content(@item_1a.name)
        expect(page).to have_content("$#{format("%.2f", (@item_1a.unit_price / 100.0))}")
        expect(page).to have_content(@invoice_item_1a.status.capitalize)
        expect(page).to have_content(@invoice_item_1a.quantity)

        expect(page).to have_content(@item_1b.name)
        expect(page).to have_content("$#{format("%.2f", (@item_1b.unit_price / 100.0))}")
        expect(page).to have_content(@invoice_item_1b.status.capitalize)
        expect(page).to have_content(@invoice_item_1b.quantity)
      end
    end

    it "They do not see any information related to items from another merchant" do
      expect(page).to_not have_content(@item_2.name)
    end
  end

  describe "When a user visits merchant's invoice show, there is item information" do
    # 17. Merchant Invoice Show Page: Total Revenue
    #
    # As a merchant
    # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # Then I see the total revenue that will be generated from all of my items on the invoice
    before(:each) do
      @merchant_1 = create(:merchant)
      @item_1a = create(:item, merchant: @merchant_1, unit_price: 1099)
      @item_1b = create(:item, merchant: @merchant_1, unit_price: 16725)
      @customer_1 = create(:customer)

      @invoice_1 = create(:invoice, customer: @customer_1)
      @invoice_item_1a = create(:invoice_item, item: @item_1a, invoice: @invoice_1, quantity: 5)
      @invoice_item_1b = create(:invoice_item, item: @item_1b, invoice: @invoice_1, quantity: 3)

      visit merchant_invoice_path(@merchant_1, @invoice_1)
    end

    it "They see the total revenue that will be generated from all items on invoice" do
      expect(page).to have_content("Total Revenue: $556.70")
    end
  end

  describe "When a user visits merchant invoice show, there is the ability to update item status" do
    # 18. Merchant Invoice Show Page: Update Item Status
    #
    # As a merchant
    # When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
    # I see that each invoice item status is a select field
    # And I see that the invoice item's current status is selected
    # When I click this select field,
    # Then I can select a new status for the Item,
    # And next to the select field I see a button to "Update Item Status"
    # When I click this button
    # I am taken back to the merchant invoice show page
    # And I see that my Item's status has now been updated
    before(:each) do
      @merchant_1 = create(:merchant)
      @item_1a = create(:item, merchant: @merchant_1)
      @item_1b = create(:item, merchant: @merchant_1)
      @item_1c = create(:item, merchant: @merchant_1)
      @customer_1 = create(:customer)

      @invoice_1 = create(:invoice, customer: @customer_1)
      @invoice_item_1a = create(:invoice_item, item: @item_1a, invoice: @invoice_1, status: 0)
      @invoice_item_1b = create(:invoice_item, item: @item_1b, invoice: @invoice_1, status: 1)
      @invoice_item_1c = create(:invoice_item, item: @item_1c, invoice: @invoice_1, status: 2)
      visit merchant_invoice_path(@merchant_1, @invoice_1)
    end

    it "They see that each invoice item status is a select field" do
      within "#ItemStatus-#{@item_1a.id}" do
        expect(page).to have_css("select")
        expect(page).to have_content("Pending")
      end

      within "#ItemStatus-#{@item_1b.id}" do
        expect(page).to have_css("select")
        expect(page).to have_content("Packaged")
      end

      within "#ItemStatus-#{@item_1c.id}" do
        expect(page).to have_css("select")
        expect(page).to have_content("Shipped")
      end
    end

    it "They select a new status for the item, click on Update Item Status" do
      within "#ItemStatus-#{@item_1a.id}" do
        select("Packaged", from: :status)
        click_button("Update Item Status")
      end

      expect(current_path).to eq(merchant_invoice_path(@merchant_1, @invoice_1))

      within "#ItemStatus-#{@item_1a.id}" do
        expect(page).to have_content("Packaged")
      end

      within "#ItemStatus-#{@item_1b.id}" do
        expect(page).to have_content("Packaged")
      end

      within "#ItemStatus-#{@item_1c.id}" do
        expect(page).to have_content("Shipped")
      end
    end

    it "They see an error message when status is not changed, and page rerenders" do
      within "#ItemStatus-#{@item_1a.id}" do
        select("Pending", from: :status)
        click_button("Update Item Status")
      end

      expect(current_path).to eq(merchant_invoice_path(@merchant_1, @invoice_1))
      expect(page).to have_content("Status must be changed")

      within "#ItemStatus-#{@item_1a.id}" do
        expect(page).to have_content("Packaged")
      end
    end
  end
end
