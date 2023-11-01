require "rails_helper"

RSpec.describe Invoice do
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
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

  describe 'class methods' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)
      @customer_1 = create(:customer)

      @invoice_1 = create(:invoice, customer: @customer_1)
      create(:invoice_item, item: @item_1, invoice: @invoice_1)
      @invoice_2 = create(:invoice, customer: @customer_1)
      create(:invoice_item, item: @item_1, invoice: @invoice_2)
      @invoice_3 = create(:invoice, customer: @customer_1)
      create(:invoice_item, invoice: @invoice_3)
    end

    describe '.invoices_for_merchant' do
      it 'returns list of invoices for a specific merchant id' do
        expect(Invoice.invoices_for_merchant(@merchant_1.id)).to eq([@invoice_1, @invoice_2])
      end
    end
  end

end
