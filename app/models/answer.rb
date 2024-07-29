class Answer < ApplicationRecord
  validates :body, :body, presence: true
  
  belongs_to :question
end
