class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true
  validates :status, presence: false

  enum status: %w[disabled enabled]

  def favorite_customers
    customers_ordered_by_num_trx(:desc).first(5)
  end

  # the WHERE clause filters the results given the instance self.id
  def customers_ordered_by_num_trx(sorted = :desc)
    Customer.find_by_sql(
      "SELECT
          CUSTOMERS.*,
          COUNT(DISTINCT TRANSACTIONS.ID)
        FROM
          CUSTOMERS
          INNER JOIN INVOICES ON CUSTOMERS.ID = INVOICES.CUSTOMER_ID
          INNER JOIN INVOICE_ITEMS ON INVOICES.ID = INVOICE_ITEMS.INVOICE_ID
          INNER JOIN ITEMS ON INVOICE_ITEMS.ITEM_ID = ITEMS.ID
          INNER JOIN TRANSACTIONS ON TRANSACTIONS.INVOICE_ID = INVOICES.ID
        WHERE
          ITEMS.MERCHANT_ID = #{id} AND
          TRANSACTIONS.RESULT = 0
        GROUP BY
          CUSTOMERS.ID
        ORDER BY
          count #{sorted},
          first_name"
    )
  end

  def top_five_items
    Item.joins(:transactions)
      .joins(:invoice_items)
      .group(:id)
      .where("transactions.result = ?", "0")
      .where("items.merchant_id = ?", id)
      .select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .order("revenue DESC")
      .limit(5)
  end


  def total_revenue
    revenue = invoices
      .joins(:invoice_items, :transactions)
      .where("transactions.result = 0")
      .sum("invoice_items.quantity * invoice_items.unit_price")
    sprintf("%.2f", revenue)
  end

  def best_day
    day = invoices
      .joins(:invoice_items, :transactions)
      .where("transactions.result = 0")
      .select("invoices.updated_at, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
      .group("invoices.updated_at")
      .order("revenue desc, invoices.updated_at desc")
      .first
    day.updated_at.strftime("%m/%d/%Y") if day
  end

  def self.top_five_by_revenue
    joins(invoices: [:invoice_items, :transactions])
      .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
      .where("transactions.result = 0")
      .group(:id)
      .order("revenue desc")
      .limit(5)
  end
end
