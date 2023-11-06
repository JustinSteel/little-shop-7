require "rails_helper"

RSpec.describe InvoiceItem do
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_one(:merchant).through(:item) }
  end

  describe "validations" do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
    it { should validate_numericality_of :quantity }
    it { should validate_numericality_of :unit_price }
    it { should define_enum_for(:status).with_values(pending: 0, packaged: 1, shipped: 2) }
  end

  describe "instance methods" do
    before(:each) do
      # load_test_data
      @m = create(:merchant)
      @items = create_list(:item, 3, merchant: @m)
      @invoice_items = [
        create(:invoice_item, item: @items[0], status: "shipped"),
        create(:invoice_item, item: @items[0], status: "pending"),
        create(:invoice_item, item: @items[1], status: "packaged"),
        create(:invoice_item, item: @items[2], status: "packaged"),
        create(:invoice_item, item: create(:item), status: "packaged")
      ]
    end

    describe "#items_ready_to_ship" do
      it "returns list of invoice items ready to ship when called on a merchant's invoice items" do
        # 4. Merchant Dashboard Items Ready to Ship
        # As a merchant
        # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
        # Then I see a section for "Items Ready to Ship"
        # In that section I see a list of the names of all of my items that
        # have been ordered and have not yet been shipped,
        # And next to each Item I see the id of the invoice that ordered my item
        # And each invoice id is a link to my merchant's invoice show page
        # require 'pry'; binding.pry
        expect(@m.invoice_items.items_ready_to_ship).to eq @invoice_items[1..3]
      end
    end
  end
end
