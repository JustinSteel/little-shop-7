require "rails_helper"

RSpec.describe "Merchants-New merchant page" do
  it "has a form to create a new merchant" do
    visit new_admin_merchant_path

    expect(page).to have_content("Create New Merchant")
    expect(page).to have_content("Name")
    expect(page).to have_button("Submit")
  end

  it "creates a new merchants and is taken back to index page where new merchant is within disabled section" do
    visit new_admin_merchant_path

    fill_in :name, with: "Karl"
    click_button "Submit"

    expect(current_path).to eq(admin_merchants_path)
    expect(page).to have_content("Information has been successfully updated")
    expect(page).to have_content("Karl")
    expect(page).to have_button("Disable Karl")
  end

  it "does not create a merchant without valid data" do
    visit new_admin_merchant_path

    click_button "Submit"
    expect(current_path).to eq(new_admin_merchant_path)
    expect(page).to have_content("Error: All fields must be filled in to submit")
  end
end
