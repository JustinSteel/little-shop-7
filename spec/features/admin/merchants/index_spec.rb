require "rails_helper"

RSpec.describe "Merchants-Index page" do 

  it "index page with merchants" do
    load_test_data
    
    visit admin_merchants_path
    expect(page).to have_content("Admin Merchant Index")

    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
    expect(page).to have_content(@merchant4.name)
    expect(page).to have_content(@merchant5.name)
    expect(page).to have_content(@merchant6.name)
    expect(page).to have_content(@merchant7.name)
    expect(page).to have_content(@merchant8.name)
    expect(page).to have_content(@merchant9.name)
    expect(page).to have_content(@merchant10.name)
  end 

  it "has a enable button on disabled merchants" do
    merchant1= Merchant.create!(name: "Loki", status: "disabled")
    merchant2 = Merchant.create!(name: "Karl", status: "enabled")
    merchant3 = Merchant.create!(name: "Nova", status: "enabled")

    visit admin_merchants_path
    
    expect(find("#merchant-#{merchant1.id}")).to have_button("Enable #{merchant1.name}")
    expect(find("#merchant-#{merchant2.id}")).to_not have_button("Enable #{merchant2.name}")
    expect(find("#merchant-#{merchant3.id}")).to_not have_button("Enable #{merchant3.name}")
  end

  it "has a disable button on enabled merchants" do
    merchant1= Merchant.create!(name: "Loki", status: "disabled")
    merchant2 = Merchant.create!(name: "Karl", status: "enabled")
    merchant3 = Merchant.create!(name: "Nova", status: "enabled")

    visit admin_merchants_path
    
    expect(find("#merchant-#{merchant2.id}")).to have_button("Disable #{merchant2.name}")
    expect(find("#merchant-#{merchant3.id}")).to have_button("Disable #{merchant3.name}")
    expect(find("#merchant-#{merchant1.id}")).to_not have_button("Disable #{merchant1.name}")
  end
end 