require "faker"

FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..10) }
    unit_price { Faker::Number.number(digits: 4) }
    status { rand(0..2) }
  end
end
