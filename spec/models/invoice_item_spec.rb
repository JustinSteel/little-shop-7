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
end
