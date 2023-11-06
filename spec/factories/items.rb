require 'faker'

FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Commerce.material }
    unit_price { Faker::Commerce.price }
    status { rand(0..1)}
  end
end