class Merchant < ApplicationRecord
  has_many :items

  enum status: %w[disabled enabled]
end
