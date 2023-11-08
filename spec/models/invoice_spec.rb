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

  describe "class methods" do
    describe "::incomplete_invoice" do
      it "returns only invoices with items not shipped" do
        @customer_1 = Customer.create!(first_name: "Lucas", last_name: "Kleeman")
        @customer_2 = Customer.create!(first_name: "Joel", last_name: "Taylor")

        @invoice_1 = Invoice.create!(status: "completed", customer: @customer_1)
        @invoice_2 = Invoice.create!(status: "completed", customer: @customer_1)
        @invoice_3 = Invoice.create!(status: "in progress", customer: @customer_1)
        @invoice_4 = Invoice.create!(status: "in progress", customer: @customer_2)
        @invoice_5 = Invoice.create!(status: "completed", customer: @customer_2)
        @invoice_6 = Invoice.create!(status: "cancelled", customer: @customer_2)

        expect(Invoice.incomplete_invoice).to eq([@invoice_3, @invoice_4, @invoice_6])
      end
    end

    describe "::formatted_date" do
      it "returns created_at stamp in a format" do
        @customer_1 = Customer.create!(first_name: "Lucas", last_name: "Kleeman")
        @invoice_1 = Invoice.create!(status: "completed", customer: @customer_1, created_at: "2012-03-25 09:54:09 UTC")

        expect(@invoice_1.formatted_date).to eq("Sunday, March 25, 2012")
      end
    end
  end
end
