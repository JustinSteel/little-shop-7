class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: %w[pending packaged shipped]

  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
end
