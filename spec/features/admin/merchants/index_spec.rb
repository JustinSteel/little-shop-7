require "rails_helper"

RSpec.describe "Merchants-Index page" do 

  it "index page with merchants" do
    load_test_data
    
    visit admin_merchants_path
    expect(page).to have_content("Admin Merchant Index")

    expect(page).to have_link(@merchant1.name)
    expect(page).to have_link(@merchant2.name)
    expect(page).to have_link(@merchant3.name)
    expect(page).to have_link(@merchant4.name)
    expect(page).to have_link(@merchant5.name)
    expect(page).to have_link(@merchant6.name)
    expect(page).to have_link(@merchant7.name)
    expect(page).to have_link(@merchant8.name)
    expect(page).to have_link(@merchant9.name)
    expect(page).to have_link(@merchant10.name)
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

  it "has a link to create a new merchant" do 
    visit admin_merchants_path

    expect(page).to have_link("Create New Merchant")
  end

  it "directs a user to a new-merchant-page when clicking link" do 
    visit admin_merchants_path

    click_link("Create New Merchant")
    expect(current_path).to eq(new_admin_merchant_path)
  end

  it "shows top 5 merchants by revenue" do
    load_best_test_data

    visit admin_merchants_path

    expect(find("#top_5")).to have_content("#{@merchant3.name} Total Revenue: $400.00")
    expect(find("#top_5")).to have_content("#{@merchant2.name} Total Revenue: $300.00")
    expect(find("#top_5")).to have_content("#{@merchant5.name} Total Revenue: $200.00")
    expect(find("#top_5")).to have_content("#{@merchant7.name} Total Revenue: $200.00")
    expect(find("#top_5")).to have_content("#{@merchant1.name} Total Revenue: $100.00")
    expect(find("#top_5")).to_not have_content(@merchant4.name)
    expect(find("#top_5")).to_not have_content(@merchant6.name)

    within "#top_5" do
      
    end
  end

  it "shows top 5 merchants best day" do
    load_best_test_data

    visit admin_merchants_path
    within "#top_5" do
    expect(find("#top_5")).to have_content("#{@merchant3.name} Total Revenue: $400.00, Top Sales Day: 05/25/2023")
    expect(find("#top_5")).to have_content("#{@merchant2.name} Total Revenue: $300.00, Top Sales Day: 03/15/2023")
    expect(find("#top_5")).to have_content("#{@merchant5.name} Total Revenue: $200.00, Top Sales Day: 07/01/2023")
    expect(find("#top_5")).to have_content("#{@merchant7.name} Total Revenue: $200.00, Top Sales Day: 10/27/2023")
    expect(find("#top_5")).to have_content("#{@merchant1.name} Total Revenue: $100.00, Top Sales Day: 11/07/2023")
    expect(find("#top_5")).to_not have_content(@merchant4.name)
    expect(find("#top_5")).to_not have_content(@merchant6.name)
    end
  end
end
