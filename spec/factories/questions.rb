# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { 'Test title' }
    body { 'Test body' }
    author { association :user }

    trait :invalid do
      title { nil }
    end
  end
end
