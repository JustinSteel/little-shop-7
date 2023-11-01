class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: ["completed", "cancelled", "in progress"]

  validates :status, presence: true

  def self.invoices_for_merchant(merchant_id)
    select("invoices.*").joins(invoice_items: :item).where("merchant_id = ?", merchant_id)
  end
end
