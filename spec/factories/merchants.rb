require 'faker'

FactoryBot.define do
  factory :merchant do
    name { Faker::Fantasy::Tolkien.character }
    status { rand(0..1) }
  end
end