require "rails_helper"

RSpec.describe Merchant do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should define_enum_for(:status).with_values(disabled: 0, enabled: 1) }
  end

  before(:each) do
    load_best_test_data
  end

  describe "instance methods" do
    before(:each) do
      @customer_2 = create(:customer)
      @invoice_15 = create(:invoice, customer: @customer_2)
      create(:invoice_item, item_id: @item1.id, invoice_id: @invoice_15.id)
      @transaction_14 = create(:transaction, invoice: @invoice_15, result: "success")
      @transaction_15 = create(:transaction, invoice: @invoice_15, result: "success")
    end
    describe "#top_five_items" do
      it "returns top 5 items" do
        expect(@merchant1.top_five_items).to eq([@item1])
      end
    end

    describe "#customers_ordered_by_num_trx" do
      it "returns customers ordered by number of transactions" do
        results = @merchant1.customers_ordered_by_num_trx(:desc)

        expect(results).to match_array [@customer_2, @customer_1]
      end
    end

    describe "#customers_ordered_by_num_trx" do
      it "should return the customers ordered from most transactions to least" do
        results = @merchant1.customers_ordered_by_num_trx(:desc)

        expect(results).to match_array [@customer_2, @customer_1]
      end
    end

    describe "#favorite_customers" do
      it "should return the top 5 customers ordered from most transactions to least" do
        results = @merchant1.favorite_customers

        expect(results).to match_array [@customer_2, @customer_1]
      end
    end

    describe "#total_revenue" do
      it "returns a merchants total rev" do
        expect(@merchant2.total_revenue).to eq("300.00")
      end
    end

    describe "#best_day" do
      it "returns the date of the highest single day rev" do
        expect(@merchant2.best_day).to eq("03/15/2023")
      end
    end
  end

  describe "class methods" do
    describe ".top_five_by_revenue" do
      it "returns top 5 merchants by revenue" do
        expect(Merchant.top_five_by_revenue).to eq([@merchant3, @merchant2, @merchant5, @merchant7, @merchant1])
      end
    end
  end
end
