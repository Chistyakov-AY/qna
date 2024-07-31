# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body { 'MyString' }
    question_id { create(:question).id }

    trait :invalid do
      body { nil }
    end
  end
end
