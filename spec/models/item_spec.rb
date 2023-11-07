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

  describe "instance methods" do
    describe "#opp_status" do
      it "shows the opposite status of the item" do
        load_test_data
        expect(@item7.opp_status).to eq "disabled"
        @item7.update!(status: "disabled")
        expect(@item7.opp_status).to eq "enabled"
      end
    end
  end
end
