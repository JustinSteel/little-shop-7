require "faker"

FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Commerce.material }
    unit_price { Faker::Number.number(digits: 5) }
    status { rand(0..1) }

    association :merchant, factory: :merchant
  end
end
