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
end
