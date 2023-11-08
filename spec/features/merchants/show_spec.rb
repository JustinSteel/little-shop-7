require "rails_helper"

RSpec.describe "Merchant Dashboard" do
  it "has the merchant's name" do
    merchant = Merchant.create!(name: "Bob's Burgers", status: 1)
    # US 1
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    visit dashboard_merchant_path(merchant)
    # Then I see the name of my merchant
    expect(page).to have_content(merchant.name)
  end

  it "has a link to my merchant items index" do
    merchant = Merchant.create!(name: "Bob's Burgers", status: 1)
    # US 2
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    visit dashboard_merchant_path(merchant)
    # Then I see link to my merchant items index (/merchants/:merchant_id/items)
    expect(page).to have_link("#{merchant.name} Items")
    # And I see a link to my merchant invoices index (/merchants/:merchant_id/invoices)
    expect(page).to have_link("#{merchant.name} Invoices")
  end

  before(:each) do
    load_test_data
    @cust = create(:customer)
    @invoice = create(:invoice, customer: @cust)
    create(:invoice_item, item_id: @item1.id, invoice_id: @invoice.id)
    @transaction3a = create(:transaction, invoice: @invoice, result: "success")
    @transaction3b = create(:transaction, invoice: @invoice, result: "success")
  end

  it "shows statistics for a favorite customers" do
    # 3. Merchant Dashboard Statistics - Favorite Customers
    #
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see the names of the top 5 customers
    # who have conducted the largest number of successful transactions with my merchant
    # And next to each customer name I see the number of successful transactions they have
    # conducted with my merchant
    visit dashboard_merchant_path(@merchant1)

    within(".favorite-customers") do
      @merchant1.favorite_customers.each do |cust|
        expect(page).to have_content "#{cust.first_name} #{cust.last_name} | Transactions: #{cust.count}"
      end
    end
  end

  it "has a section of items ready to ship" do
    # 4. Merchant Dashboard Items Ready to Ship
    # As a merchant
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see a section for "Items Ready to Ship"
    # In that section I see a list of the names of all of my items that
    # have been ordered and have not yet been shipped,
    # And next to each Item I see the id of the invoice that ordered my item
    # And each invoice id is a link to my merchant's invoice show page
    visit dashboard_merchant_path(@merchant1)

    within ".ship-items" do
      @merchant1.invoice_items.items_ready_to_ship.each do |inv_item|
        expect(page).to have_content(
          "#{inv_item.item.name} | Invoice ID: #{inv_item.invoice_id} | Created: #{inv_item.created_at.to_formatted_s(:merchants)}"
        )
        assert page.has_link?(href: merchant_invoice_path(@merchant1, inv_item.invoice))
      end
    end
  end

  it "has a section for invoices sorted by least recent" do
    # 5. Merchant Dashboard Invoices sorted by least recent
    # As a merchant
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # In the section for "Items Ready to Ship",
    # Next to each Item name I see the date that the invoice was created
    # And I see the date formatted like "Monday, July 18, 2019"
    # And I see that the list is ordered from oldest to newest
    visit dashboard_merchant_path(@merchant1)

    within ".ship-items" do
      @merchant1.invoice_items.items_ready_to_ship.each do |inv_item|
        expect(page).to have_content(
          "#{inv_item.item.name} | Invoice ID: #{inv_item.invoice_id} | Created: #{inv_item.created_at.to_formatted_s(:merchants)}"
        )
      end
    end

    invoices = @merchant1.invoice_items.where.not(status: "shipped").order(created_at: :asc)
    expect(invoices.first.item.name).to appear_before invoices[2].item.name
  end
end