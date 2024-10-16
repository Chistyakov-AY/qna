# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many_attached :files
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  validates :title, :body, presence: true
end
