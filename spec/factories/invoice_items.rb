FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..10) }
    unit_price {item.unit_price }
    status { rand(0..2)}

    association :item, factory: :item
    association :invoice, factory: :invoice
  end
end