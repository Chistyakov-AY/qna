# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  validates :body, presence: true

  scope :sort_by_best, -> { order(best: :desc) }

  def choose_the_best_answer
    transaction do
      self.class.where(question_id:).update_all(best: false)
      update(best: true)
    end
  end
end
