class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: false

  enum status: %w[disabled enabled]

  def opp_status
    self.disabled? ? "enabled" : "disabled"
  end
end
