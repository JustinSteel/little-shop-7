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
  end

  describe "class methods" do
  end

  describe "instance methods" do
    describe "#customers_ordered_by_num_trx" do
      it "returns customers ordered by number of transactions" do
        results = @merchant1.customers_ordered_by_num_trx(:desc)
        require 'pry'; binding.pry
      end
    end
    describe "#favorite_customers" do
      it "should return the customers ordered from most transactions to least" do
      end
    end
  end
end
