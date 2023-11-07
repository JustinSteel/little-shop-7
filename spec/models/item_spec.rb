require "rails_helper"

RSpec.describe Item do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    # it { should validate_presence_of :status }
    it { should validate_numericality_of :unit_price }
    it { should define_enum_for(:status).with_values(disabled: 0, enabled: 1) }
  end

  describe 'test methods' do
    before(:each) do
      @merchant = create(:merchant)
      @invoice_1 = create(:invoice, customer: create(:customer))
      @invoice_2 = create(:invoice, customer: create(:customer))
      @invoice_3 = create(:invoice, customer: create(:customer))
      @invoice_4 = create(:invoice, customer: create(:customer))
      @invoice_5 = create(:invoice, customer: create(:customer))
      @invoice_6 = create(:invoice, customer: create(:customer))
      @item_1 = create(:item, merchant: @merchant, unit_price: 1234)
      @item_2 = create(:item, merchant: @merchant)
      @item_3 = create(:item, merchant: @merchant)
      @item_4 = create(:item, merchant: @merchant)
      @item_5 = create(:item, merchant: @merchant)
      @item_6 = create(:item, merchant: @merchant)
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

    describe "#revenue_sold" do
      it "returns the total revenue from completed tranactions for an item" do
        expect(@item_1.revenue_sold).to eq(1250000)
      end
    end
  end

end