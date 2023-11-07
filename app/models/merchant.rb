class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: %w[disabled enabled]

  validates :name, presence: true
  validates :status, presence: false

  def self.top_five_by_revenue
    joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .where("transactions.result = 0")
    .group(:id)
    .order("revenue desc")
    .limit(5)
  end

  def total_revenue
    revenue = self.invoices
    .joins(:invoice_items, :transactions)
    .where("transactions.result = 0")
    .sum("invoice_items.quantity * invoice_items.unit_price")
    sprintf('%.2f', revenue)
  end

end
