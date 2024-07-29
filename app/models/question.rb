# frozen_string_literal: true

# Comment
class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true
end
