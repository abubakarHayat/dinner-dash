FactoryBot.define do
  factory :category do
    category_name { 'Category 1' }

    trait :no_name do
      category_name { '' }
    end

    factory :no_category, traits: [:no_name]
  end
end
