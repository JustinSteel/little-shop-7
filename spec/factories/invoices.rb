FactoryBot.define do
  factory :invoice do
    status { rand(0..2) }

    association :customer, factory: :customer
  end
end
