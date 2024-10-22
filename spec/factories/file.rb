# frozen_string_literal: true

FactoryBot.define do
  factory :file do
    association :answer
    association :question
  end
end
