require 'faker'

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    display_name { Faker::Name.initials }
    password { Faker::Internet.password }
    email { Faker::Internet.email }
    confirmed_at { Time.zone.now }

    trait :no_f_name do
      first_name { nil }
    end
    trait :no_l_name do
      last_name { nil }
    end
    trait :no_password do
      password { nil }
    end
    trait :short_password do
      password { '12345' }
    end
    trait :new_email do
      email { 'abc@abc.com' }
    end
    trait :no_disp_name do
      display_name { '' }
    end
    trait :admin do
      role { 1 }
    end
    factory :user_new_email, traits: %i[new_email no_disp_name]
    factory :user_admin, traits: %i[admin]
    factory :user_inv, traits: %i[no_f_name no_l_name no_password no_l_name]
    factory :user_inv2, traits: %i[no_f_name no_l_name short_password no_l_name]
  end
end
