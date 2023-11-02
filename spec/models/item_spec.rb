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
    it { should validate_presence_of :status }
    it { should validate_numericality_of :unit_price }
    it { should define_enum_for(:status).with_values(disabled: 0, enabled: 1) }
  end

  describe "instance methods for merchant invoice" do
    before(:each) do
      @merchant_1 = create(:merchant)
      @item_1a = create(:item, merchant: @merchant_1)
      @item_1b = create(:item, merchant: @merchant_1)
      @customer_1 = create(:customer)

      @invoice_1 = create(:invoice, customer: @customer_1)
      @invoice_item_1a = create(:invoice_item, item: @item_1a, invoice: @invoice_1)
      @invoice_item_1b = create(:invoice_item, item: @item_1b, invoice: @invoice_1)
    end

    describe '#quantity_on_invoice_item' do
      it 'returns quantity of item from invoice_item' do
        expect(@item_1a.quantity_on_invoice_item).to eq(@invoice_item_1a.quantity)
        expect(@item_1b.quantity_on_invoice_item).to eq(@invoice_item_1b.quantity)
      end
    end

    describe '#status_on_invoice_item' do
      it 'returns status of item from invoice_item' do
        expect(@item_1a.status_on_invoice_item).to eq(@invoice_item_1a.status)
        expect(@item_1b.status_on_invoice_item).to eq(@invoice_item_1b.status)
      end
    end
  end
end
