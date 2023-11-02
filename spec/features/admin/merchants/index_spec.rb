require "rails_helper"

RSpec.describe "Merchants-index page" do 
  before :each do 
    load_test_data
  end
  it "shows all merchants in the system" do
    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    visit admin_merchants_path
    # Then I see the name of each merchant in the system
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
end