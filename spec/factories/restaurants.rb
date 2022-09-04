FactoryBot.define do
  factory :restaurant do
    restaurant_name { 'Restaurant 1' }

    trait :no_name do
      restaurant_name { '' }
    end

    factory :no_restaurant, traits: [:no_name]
  end
end
