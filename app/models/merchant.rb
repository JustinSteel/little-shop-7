class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates :name, presence: true
  validates :status, presence: false

  enum status: %w[disabled enabled]

  def favorite_customers
    customers_ordered_by_num_trx(:desc).first(5)
  end

  # the WHERE clause filters the results given the instance self.id
  def customers_ordered_by_num_trx(sorted)
    Merchant.find_by_sql("
      SELECT
        CUSTOMERS.*,
        count(DISTINCT TRANSACTIONS.ID)
      FROM
        CUSTOMERS
        INNER JOIN INVOICES ON CUSTOMERS.ID = INVOICES.CUSTOMER_ID
        INNER JOIN INVOICE_ITEMS ON INVOICES.ID = INVOICE_ITEMS.INVOICE_ID
        INNER JOIN ITEMS ON INVOICE_ITEMS.ITEM_ID = ITEMS.ID
        INNER JOIN INVOICES INVOICES_CUSTOMERS_JOIN ON INVOICES_CUSTOMERS_JOIN.CUSTOMER_ID = CUSTOMERS.ID
        INNER JOIN TRANSACTIONS ON TRANSACTIONS.INVOICE_ID = INVOICES_CUSTOMERS_JOIN.ID
      WHERE
        ITEMS.MERCHANT_ID = #{id}
      GROUP BY
        CUSTOMERS.ID
      ORDER BY
        count #{sorted}")

    # equivalent AR chaining
    # Customer
    #   .select("customers.*, COUNT(DISTINCT transactions.id) AS transactions_count")
    #   .joins(invoices: {invoice_items: :item})
    #   .where(items: {merchant_id: id})
    #   .group("customers.id")
    #   .order(Arel.sql("transactions_count #{sorted}"))
  end
end
