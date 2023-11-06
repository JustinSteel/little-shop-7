require "rails_helper"

RSpec.describe Merchant do
  describe "relationships" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should define_enum_for(:status).with_values(disabled: 0, enabled: 1) }
  end

  before(:each) do
    load_best_test_data
    @customer_2 = create(:customer)
    @invoice_15 = create(:invoice, customer: @customer_2)
    create(:invoice_item, item_id: @item1.id, invoice_id: @invoice_15.id)
    @transaction_14 = create(:transaction, invoice: @invoice_15, result: "success")
    @transaction_15 = create(:transaction, invoice: @invoice_15, result: "success")
  end

  describe "class methods" do
  end

  describe "instance methods" do
    describe "#customers_ordered_by_num_trx" do
      it "returns customers ordered by number of transactions" do
        results = @merchant1.customers_ordered_by_num_trx(:desc)

        expect(results).to match_array [@customer_2, @customer_1]
      end
    end
    describe "#favorite_customers" do
      it "should return the customers ordered from most transactions to least" do
        results = @merchant1.customers_ordered_by_num_trx(:desc)

        expect(results).to match_array [@customer_2, @customer_1]
      end
    end
  end
end
