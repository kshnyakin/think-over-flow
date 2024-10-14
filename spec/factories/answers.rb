FactoryBot.define do
  factory :answer do
    body 'Text of my answer'
    question
    association :author, factory: :user

    trait :invalid do
      body { nil }
    end
  end
end
