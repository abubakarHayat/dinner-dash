require 'faker'

FactoryBot.define do
  factory :item do
    item_title { Faker::Food.dish }
    item_description { Faker::Food.description }
    item_price { 320 }
    association :restaurant, strategy: :build
    restaurant_id { restaurant.id }

    trait :invalid do
      id { '000' }
      restaurant_id { '000' }
    end

    trait :attr do
      # rest = Restaurant.create(restaurant_name: 'Restt 1')
      restaurant_id { rest.id }
    end

    factory :item_inv, traits: %i[invalid]
    factory :item_attr, traits: %i[attr]
  end
end
