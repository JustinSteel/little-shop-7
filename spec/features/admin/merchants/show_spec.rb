require "rails_helper"

RSpec.describe "Merchants-Show page" do 
  before :each do 
    load_test_data
  end

  it "renders a merchants show page to the user" do 
    visit admin_merchant_path(@merchant3)

    expect(page).to have_content("#{@merchant3.name} Show Page")
    expect(page).to_not have_content("#{@merchant10.name} Show Page")
  end

  it "has a button to edit a merchant" do 
    visit admin_merchant_path(@merchant3)

    expect(page).to have_link("Update Merchant")
  end

  it "reroutes a user to the edit pagge to update a merchant" do 
    visit admin_merchant_path(@merchant3)

    click_link("Update Merchant")
    expect(current_path).to eq("/admin/merchants/#{@merchant3.id}/edit")
  end
end