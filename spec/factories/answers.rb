# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body { 'Test answer' }
    question { association :question }
    author { association :user }

    trait :invalid do
      body { nil }
    end
  end
end
