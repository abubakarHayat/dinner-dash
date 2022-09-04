FactoryBot.define do
  factory :cart do
    association :user, strategy: :build
    user_id { user.id }

    trait :no_user do
      user_id { nil }
    end

    factory :cart_no_user, traits: [:no_user]
  end
end
