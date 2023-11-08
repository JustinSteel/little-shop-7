require "rails_helper"

RSpec.describe "Admin Dashboard" do
  it "has a header" do
    visit admin_path

    expect(page).to have_content("Admin Dashboard")
  end

  it "has links to admin merchants and invoices index pages" do 
    visit admin_path 

    expect(page).to have_link("Admin: Merchants")
    expect(page).to have_link("Admin: Invoices")
  end

  describe "statistics section" do 
    before :each do 
      load_test_data 
    end

    it "lists the top 5 customers" do 
      visit admin_path

      expect(page).to have_content("Top 5 Customers:")
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
      expect(page).to have_content(@customer_2.first_name)
      expect(page).to have_content(@customer_2.last_name)
      expect(page).to have_content(@customer_3.first_name)
      expect(page).to have_content(@customer_3.last_name)
      expect(page).to have_content(@customer_4.first_name)
      expect(page).to have_content(@customer_4.last_name)
      expect(page).to have_content(@customer_5.first_name)
      expect(page).to have_content(@customer_5.last_name)
      within "#customer-#{@customer_3.id}"
        expect(page).to have_content("4 Transactions")
      end
  end

  describe "Incomplete invoices" do 
    before :each do 
      load_test_data
    end

    it "lists all invoices with items not shipped" do 
      visit admin_path

      expect(page).to have_content("Incomplete Invoices:")
      expect(page).to have_content(@invoice_1.id) 
      expect(page).to have_content(@invoice_1.formatted_date) 
      expect(page).to have_content(@invoice_1a.id) 
      expect(page).to have_content(@invoice_1a.formatted_date) 
      expect(page).to have_content(@invoice_1b.id) 
      expect(page).to have_content(@invoice_1b.formatted_date) 
      expect(page).to have_content(@invoice_1c.id) 
      expect(page).to have_content(@invoice_1c.formatted_date) 
      expect(page).to have_content(@invoice_1d.id) 
      expect(page).to have_content(@invoice_1d.formatted_date) 
      expect(page).to have_content(@invoice_1e.id) 
      expect(page).to have_content(@invoice_1e.formatted_date) 
      expect(page).to have_content(@invoice_3a.id) 
      expect(page).to have_content(@invoice_3a.formatted_date) 
      expect(page).to have_content(@invoice_3b.id) 
      expect(page).to have_content(@invoice_3b.formatted_date) 
      expect(page).to have_content(@invoice_3c.id) 
      expect(page).to have_content(@invoice_3c.formatted_date) 
      expect(page).to have_content(@invoice_3d.id) 
      expect(page).to have_content(@invoice_3d.formatted_date) 
      expect(page).to have_content(@invoice_6a.id) 
      expect(page).to have_content(@invoice_6a.formatted_date) 
      expect(page).to have_content(@invoice_6b.id) 
      expect(page).to have_content(@invoice_6b.formatted_date) 
    end
  end
end
