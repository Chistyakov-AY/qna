# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many_attached :files

  validates :body, presence: true

  has_many :links, dependent: :destroy, as: :linkable
  accepts_nested_attributes_for :links, reject_if: :all_blank 

  scope :sort_by_best, -> { order(best: :desc) }

  def choose_the_best_answer
    transaction do
      self.class.where(question_id:).update_all(best: false)
      update(best: true)
    end
  end
end
