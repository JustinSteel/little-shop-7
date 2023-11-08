namespace :csv_load do
  desc "Load customers from CSV"
  task customers: [:environment] do
    require "csv"

    CSV.foreach("./db/data/customers.csv", headers: true) do |row|
      Customer.create!(row.to_h)
      # Customer.create!(first_name: row[:first_name], last_name: row[:last_name], id: row[:id])
    end
    p "Customers loaded from CSV"
  end

  desc "Load invoice items from CSV"
  task invoices: [:environment] do
    require "csv"

    CSV.foreach("./db/data/invoices.csv", headers: true) do |row|
      Invoice.create!(row.to_h)
    end
    p "Invoice loaded from CSV"
  end

  desc "Load merchant from CSV"
  task merchants: [:environment] do
    require "csv"

    CSV.foreach("./db/data/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_h)
    end
    p "Merchants loaded from CSV"
  end

  desc "Load items from CSV"
  task items: [:environment] do
    require "csv"

    CSV.foreach("./db/data/items.csv", headers: true) do |row|
      Item.create!(row.to_h)
    end
    p "Items loaded from CSV"
  end

  desc "Load transactions from CSV"
  task transactions: [:environment] do
    require "csv"

    CSV.foreach("./db/data/transactions.csv", headers: true) do |row|
      Transaction.create!(row.to_h)
    end
    p "Transactions loaded from CSV"
  end

  desc "Load invoice items from CSV"
  task invoice_items: [:environment] do
    require "csv"

    CSV.foreach("./db/data/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end
    p "Invoice items loaded from CSV"
  end

  desc "Loads all files from CSV"
  task all: [:customers, :invoices, :merchants, :items, :transactions, :invoice_items] do
    p "All CSVs loaded successfully"
  end
end
