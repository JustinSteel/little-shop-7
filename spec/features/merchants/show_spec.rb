require "rails_helper"

RSpec.describe "Merchants dashboard page" do
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
end
