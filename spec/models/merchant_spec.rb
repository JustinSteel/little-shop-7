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

  describe 'test methods' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @invoice_1 = create(:invoice, customer: create(:customer))
      @invoice_2 = create(:invoice, customer: create(:customer))
      @invoice_3 = create(:invoice, customer: create(:customer))
      @invoice_4 = create(:invoice, customer: create(:customer))
      @invoice_5 = create(:invoice, customer: create(:customer))
      @invoice_6 = create(:invoice, customer: create(:customer))
      @item_1 = create(:item, merchant: @merchant_1, unit_price: 1234)
      @item_2 = create(:item, merchant: @merchant_1)
      @item_3 = create(:item, merchant: @merchant_1)
      @item_4 = create(:item, merchant: @merchant_1)
      @item_5 = create(:item, merchant: @merchant_1)
      @item_6 = create(:item, merchant: @merchant_1)
      @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, unit_price: 50000, quantity: 5)
      @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_2, unit_price: 40000, quantity: 1)
      @invoice_item_3 = create(:invoice_item, invoice: @invoice_3, item: @item_3, unit_price: 30000, quantity: 1)
      @invoice_item_4 = create(:invoice_item, invoice: @invoice_4, item: @item_4, unit_price: 20000, quantity: 1)
      @invoice_item_5 = create(:invoice_item, invoice: @invoice_5, item: @item_5, unit_price: 10000, quantity: 1)
      @invoice_item_6 = create(:invoice_item, invoice: @invoice_6, item: @item_6, unit_price: 6000000, status: 2)
      @transaction_1 = create_list(:transaction, 5, invoice: @invoice_1, result: 0)
      @transaction_2 = create_list(:transaction, 4, invoice: @invoice_2, result: 0)
      @transaction_3 = create_list(:transaction, 3, invoice: @invoice_3, result: 0)
      @transaction_4 = create_list(:transaction, 2, invoice: @invoice_4, result: 0)
      @transaction_5 = create_list(:transaction, 1, invoice: @invoice_5, result: 0)
      @transaction_6 = create(:transaction, invoice: @invoice_6, result: 1)
    end

    describe "#top_five_items" do
      it 'returns top 5 items' do
        expect(@merchant_1.top_five_items).to eq([@item_1, @item_2, @item_3, @item_4, @item_5])
      end
    end
  end
end
