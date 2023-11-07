class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  enum status: %w[disabled enabled]

  validates :name, presence: true
  validates :status, presence: false

  def top_five_items
    Item.joins(:transactions)
        .joins(:invoice_items)
        .group(:id)
        .where("transactions.result = ?", "0")
        .where("items.merchant_id = ?", self.id)
        .select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
        .order("revenue DESC")
        .limit(5)
  end
end