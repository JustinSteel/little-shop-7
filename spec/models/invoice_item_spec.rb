require "rails_helper"

RSpec.describe InvoiceItem do
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
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
      load_test_data
      @m = create(:merchant)
      @items = create_list(:item, 3, merchant: @m)
      @invoice_items = [
        create(:invoice_item, item: @items[0], status: "packaged"),
        create(:invoice_item, item: @items[0], status: "pending"),
        create(:invoice_item, item: @items[1], status: "packaged"),
        create(:invoice_item, item: @items[2], status: "packaged"),
        create(:invoice_item, item: create(:item), status: "packaged")
      ]
    end

    describe "#items_ready_to_ship" do
      it "returns list of items ready to ship when called on a merchant's invoice items" do
        require 'pry'; binding.pry

      end
    end
  end
end
