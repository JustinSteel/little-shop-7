class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  enum status: %w[disabled enabled]

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true

  def quantity_on_invoice_item

  end

  def status_on_invoice_item
    
  end
end
