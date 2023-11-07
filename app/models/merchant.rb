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
    require 'pry'; binding.pry
  end
end
