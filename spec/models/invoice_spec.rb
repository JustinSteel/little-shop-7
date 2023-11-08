require "rails_helper"

RSpec.describe Invoice do
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe "validations" do
    it { should validate_presence_of :status }
    it {
      should define_enum_for(:status).with_values(
        "completed" => 0,
        "cancelled" => 1,
        "in progress" => 2
      )
    }
  end

  describe "instance methods" do
    describe "#customer_full_name" do
      it "returns" do
        customer_1 = Customer.create!(first_name: "Lucas", last_name: "Kleeman")
        invoice_1 = Invoice.create!(status: "completed", customer: customer_1)
        expect(invoice_1.customer_full_name).to eq("Lucas Kleeman")
      end
    end

    describe "#total_revenue" do
      it "returns total revenue of all sold items" do
        merchant_1 = create(:merchant)
        item_1a = create(:item, merchant: merchant_1, unit_price: 1099)
        item_1b = create(:item, merchant: merchant_1, unit_price: 16725)
        customer_1 = create(:customer)

        invoice_1 = create(:invoice, customer: customer_1)
        invoice_item_1a = create(:invoice_item, item: item_1a, invoice: invoice_1, quantity: 5)
        invoice_item_1b = create(:invoice_item, item: item_1b, invoice: invoice_1, quantity: 3)

        expect(invoice_1.total_revenue).to eq(55670)
      end
    end
  end
end
