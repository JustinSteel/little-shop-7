require "rails_helper"

RSpec.describe Customer do
  describe "relationships" do
    it { have_many :invoices }
  end

  describe "validations" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe "Model method" do 
    describe "#top_customers" do 
      before :each do 
        load_test_data 
      end

      it "returns the top customers based on transactions" do 
        expect(Customer.top_customers).to match_array(
          [@customer_1, @customer_2, @customer_3, 
          @customer_4, @customer_5]
          )
      end
    end
  end
end
