require "rails_helper"

RSpec.describe "Merchant Invoices Index", type: :feature do
  describe "When a user visits merchant's invoices index, there is information" do
    # 14. Merchant Invoices Index
    #
    # As a merchant,
    # When I visit my merchant's invoices index (/merchants/:merchant_id/invoices)
    # Then I see all of the invoices that include at least one of my merchant's items
    # And for each invoice I see its id
    # And each id links to the merchant invoice show page
    before(:each) do
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)

      @invoices_with_item = []
      @invoices_without_item = []

      3.times do
        customer = create(:customer)

        invoice_with = create(:invoice, customer: customer)
        create(:invoice_item, item: @item_1, invoice: invoice_with)
        @invoices_with_item << invoice_with

        invoice_without = create(:invoice, customer: customer)
        create(:invoice_item, invoice: invoice_with)
        @invoices_without_item << invoice_without
      end
    end

    it "They see all invoices with at least one of merchant's items" do
      visit merchant_invoices_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content("My Invoices", count: 1)

      @invoices_with_item.each do |invoice|
        expect(page).to have_content("Invoice ##{invoice.id}")
      end

      @invoices_without_item.each do |invoice|
        expect(page).to_not have_content("Invoice ##{invoice.id}")
      end
    end

    it "They see each invoice links to the merchant invoice show page" do
      visit merchant_invoices_path(@merchant_1)

      @invoices_with_item.each do |invoice|
        click_link("Invoice ##{invoice.id}")
        expect(current_path).to eq(merchant_invoice_path(@merchant_1, invoice))
        visit merchant_invoices_path(@merchant_1)
      end
    end
  end
end
