FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..10) }
    status { rand(0..2)}
  end
end