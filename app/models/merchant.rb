class Merchant < ApplicationRecord
  has_many :items
  validates :name, presence: true
  validates :status, presence: false

  enum status: %w[disabled enabled]

  def favorite_customers
  end

  def customers_by_num_trx(sorted)
  end
end
