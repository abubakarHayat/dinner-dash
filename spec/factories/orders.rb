FactoryBot.define do
  factory :order do
    association :user, strategy: :build
    user_id { user.id }
    total { 1080 }
    status { 0 }
  end
end
