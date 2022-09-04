require 'faker'

FactoryBot.define do
  factory :item do
    item_title { Faker::Food.dish }
    item_description { Faker::Food.description }
    item_price { 320 }
    association :restaurant, strategy: :build
    restaurant_id { restaurant.id }
  end
end
