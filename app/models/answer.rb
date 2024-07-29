# frozen_string_literal: true

# Comment
class Answer < ApplicationRecord
  belongs_to :question

  validates :body, :body, presence: true
end
