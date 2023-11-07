require "rails_helper"

RSpec.describe Merchant do
  describe "relationships" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    # it { should validate_presence_of :status }
    it { should define_enum_for(:status).with_values(disabled: 0, enabled: 1) }
  end

  describe "instance methods" do
    before :each do
      load_best_test_data
    end
    
    it "#total_revenue" do
      expect(@merchant2.total_revenue).to eq("300.00")
    end
  end

  describe "class methods" do
    before :each do
      load_best_test_data
    end

    it ".top_five_by_revenue" do
      expect(Merchant.top_five_by_revenue).to eq([@merchant3, @merchant2, @merchant5, @merchant7, @merchant1])
    end
  end
end
