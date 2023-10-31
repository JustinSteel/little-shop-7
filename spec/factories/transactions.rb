require 'faker'

FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Business.credit_card_number.delete('-') }
    credit_card_expiration_date { "0#{rand(1..9)}/#{25..28}" }
    result { rand(0..1)}
  end
end