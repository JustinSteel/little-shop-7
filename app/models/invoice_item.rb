class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: %w[pending packaged shipped]

  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true

  def self.items_ready_to_ship
    where.not(status: "shipped")
    # m.invoice_items.joins(:item).select("items.*, invoice_id").where.not(status: "shipped").group("items.id", :invoice_id).order("items.id")
  end
end
