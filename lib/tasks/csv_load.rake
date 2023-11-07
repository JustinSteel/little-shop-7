namespace :csv_load do
  desc "Load customers from CSV"
  task customers: [:environment] do
    require "csv"

    CSV.foreach("./db/data/customers.csv", headers: true) do |row|
      Customer.create!(row.to_h)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!("customers")

    ActiveRecord::Base.connection.reset_pk_sequence!("customers")
    p "Customers loaded from CSV"
    # require "byebug"; byebug
  end

  desc "Load invoice items from CSV"
  task invoices: [:environment] do
    require "csv"

    CSV.foreach("./db/data/invoices.csv", headers: true) do |row|
      Invoice.create!(row.to_h)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!("invoices")

    ActiveRecord::Base.connection.reset_pk_sequence!("invoices")
    p "Invoice loaded from CSV"
  end

  desc "Load merchant from CSV"
  task merchants: [:environment] do
    require "csv"

    CSV.foreach("./db/data/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_h)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!("merchants")
    p "Merchants loaded from CSV"
  end

  desc "Load items from CSV"
  task items: [:environment] do
    require "csv"

    CSV.foreach("./db/data/items.csv", headers: true) do |row|
      Item.create!(row.to_h)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!("items")
    p "Items loaded from CSV"
  end

  desc "Load transactions from CSV"
  task transactions: [:environment] do
    require "csv"

    CSV.foreach("./db/data/transactions.csv", headers: true) do |row|
      Transaction.create!(row.to_h)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!("transactions")
    p "Transactions loaded from CSV"
  end

  desc "Load invoice items from CSV"
  task invoice_items: [:environment] do
    require "csv"

    CSV.foreach("./db/data/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!("invoice_items")
    p "Invoice items loaded from CSV"
  end

  desc "Loads all files from CSV"
  task all: [:customers, :invoices, :merchants, :items, :transactions, :invoice_items] do
    p "All CSVs loaded successfully"
  end
end
