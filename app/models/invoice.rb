class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: ["completed", "cancelled", "in progress"]

  validates :status, presence: true

  def self.incomplete_invoice 
    where("status != 0")
  end

  def formatted_date
    created_at.strftime("%A, %B %d, %Y")
  end
end
