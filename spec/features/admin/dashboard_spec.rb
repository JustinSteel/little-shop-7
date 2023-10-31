require "rails_helper"

RSpec.describe "Admin Dashboard" do
  it "has a header" do
    visit admin_path

    expect(page).to have_content("Admin Dashboard")
  end
end
