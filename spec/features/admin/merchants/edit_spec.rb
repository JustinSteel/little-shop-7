require "rails_helper"

RSpec.describe "Admin Merchant Edit" do 
  before :each do 
    load_test_data
  end

  it "has an edit page and form to update Admin Merchants info" do 
    visit edit_admin_merchant_path(@merchant3)

    expect(page).to have_content("Edit #{@merchant3.name}")
    expect(page).to have_field(:Name)
    expect(page).to have_button("Submit")
  end

  it "can update and redirect a user once valid data is inputted" do 
    visit edit_admin_merchant_path(@merchant3)

    fill_in "Name", with: "Loki"
    click_button "Submit"

    expect(current_path).to eq(admin_merchant_path(@merchant3))
    expect(page).to have_content("Loki")
    expect(page).to have_content("Information has been successfully updated")
    expect(page).to_not have_content("kiki")
  end
end