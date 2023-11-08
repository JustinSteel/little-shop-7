class Merchant < ApplicationRecord
  has_many :items

  enum status: %w[disabled enabled]

  validates :name, presence: true
  validates :status, presence: true
end
