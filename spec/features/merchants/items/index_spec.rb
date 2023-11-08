require "rails_helper"

RSpec.describe "Merchant items index page" do
  before(:each) do
    load_test_data
  end

  it "shows all the items and none of them for other merchants" do
    # 6. Merchant Items Index Page
    #
    # As a merchant,
    # When I visit my merchant items index page (merchants/:merchant_id/items)
    # I see a list of the names of all of my items
    # And I do not see items for any other merchant
    visit merchant_items_path(@merchant1)

    within ".items" do
      @merchant1.items.each do |item|
        expect(page).to have_content item.name
      end
    end

    expect(page).to_not have_content create(:item).name  # weak test but test data has shared names for items
  end

  it "has a link to the item show page from the item name" do
    # 7. Merchant Items Show Page
    #
    # As a merchant,
    # When I click on the name of an item from the merchant items index page, (merchants/:merchant_id/items)
    # Then I am taken to that merchant's item's show page (/merchants/:merchant_id/items/:item_id)
    # And I see all of the item's attributes including:
    #
    # - Name
    # - Description
    # - Current Selling Price
    visit merchant_items_path(@merchant1)

    item = @merchant1.items.first
    click_on item.name

    expect(page).to have_current_path merchant_item_path(@merchant1, item)
  end

  it "has a button to disable/enable the item" do
    # 9. Merchant Item Disable/Enable
    #
    # As a merchant
    # When I visit my items index page (/merchants/:merchant_id/items)
    # Next to each item name I see a button to disable or enable that item.
    # When I click this button
    # Then I am redirected back to the items index
    # And I see that the items status has changed
    visit merchant_items_path(@merchant1)

    within("#item-#{@merchant1.items.first.id}") do
      expect(page).to have_button "Disable"
      click_button "Disable"
    end

    within("#item-#{@merchant1.items.first.id}") do
      expect(page).to have_button "Enable"
    end
  end

  describe "Top 5 most popular items" do
    before(:each) do
      @merchant_1 = create(:merchant)
      @invoice_1 = create(:invoice, customer: create(:customer))
      @invoice_2 = create(:invoice, customer: create(:customer))
      @invoice_3 = create(:invoice, customer: create(:customer))
      @invoice_4 = create(:invoice, customer: create(:customer))
      @invoice_5 = create(:invoice, customer: create(:customer))
      @invoice_6 = create(:invoice, customer: create(:customer))
      @item_1 = create(:item, merchant: @merchant_1, unit_price: 1234)
      @item_2 = create(:item, merchant: @merchant_1)
      @item_3 = create(:item, merchant: @merchant_1)
      @item_4 = create(:item, merchant: @merchant_1)
      @item_5 = create(:item, merchant: @merchant_1)
      @item_6 = create(:item, merchant: @merchant_1)
      @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, unit_price: 55555, quantity: 5)
      @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_2, unit_price: 44444, quantity: 4)
      @invoice_item_3 = create(:invoice_item, invoice: @invoice_3, item: @item_3, unit_price: 33333, quantity: 3)
      @invoice_item_4 = create(:invoice_item, invoice: @invoice_4, item: @item_4, unit_price: 22222, quantity: 2)
      @invoice_item_5 = create(:invoice_item, invoice: @invoice_5, item: @item_5, unit_price: 11111, quantity: 1)
      @invoice_item_6 = create(:invoice_item, invoice: @invoice_6, item: @item_6, unit_price: 6000000, status: 2)
      @transaction_1 = create_list(:transaction, 5, invoice: @invoice_1, result: 0)
      @transaction_2 = create_list(:transaction, 4, invoice: @invoice_2, result: 0)
      @transaction_3 = create_list(:transaction, 3, invoice: @invoice_3, result: 0)
      @transaction_4 = create_list(:transaction, 2, invoice: @invoice_4, result: 0)
      @transaction_5 = create_list(:transaction, 1, invoice: @invoice_5, result: 0)
      @transaction_6 = create(:transaction, invoice: @invoice_6, result: 1)

      visit merchant_items_path(@merchant_1)
    end

    it "shows names of top 5 items ranked by total revenue" do
      expect(@item_1.name).to appear_before(@item_2.name)
      expect(@item_2.name).to appear_before(@item_3.name)
      expect(@item_3.name).to appear_before(@item_4.name)
      expect(@item_4.name).to appear_before(@item_5.name)
    end

    it "shows revenue next to each item name, item name is link to item show page" do
      within "#topItem-#{@item_1.id}" do
        expect(page).to have_content("1. #{@item_1.name} - $13889 in sales")
        expect(page).to have_link(@item_1.name)
      end

      within "#topItem-#{@item_2.id}" do
        expect(page).to have_content("2. #{@item_2.name} - $7111 in sales")
        expect(page).to have_link(@item_2.name)
      end

      within "#topItem-#{@item_3.id}" do
        expect(page).to have_content("3. #{@item_3.name} - $3000 in sales")
        expect(page).to have_link(@item_3.name)
      end

      within "#topItem-#{@item_4.id}" do
        expect(page).to have_content("4. #{@item_4.name} - $889 in sales")
        expect(page).to have_link(@item_4.name)
        click_on @item_4.name
      end
      expect(current_path).to eq(merchant_item_path(@merchant_1, @item_4))

      visit merchant_items_path(@merchant_1)

      within "#topItem-#{@item_5.id}" do
        expect(page).to have_content("5. #{@item_5.name} - $111 in sales")
        expect(page).to have_link(@item_5.name)
        click_on @item_5.name
      end
      expect(current_path).to eq(merchant_item_path(@merchant_1, @item_5))
    end
  end
end
