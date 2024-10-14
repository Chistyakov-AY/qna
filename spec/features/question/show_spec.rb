# frozen_string_literal: true

require 'rails_helper'

feature 'User can view the question and answers to it' do
  given(:author) { create(:user) }
  given(:question) { create(:question, author:) }
  given!(:answers) { create_list(:answer, 3, question:, author:) }

  scenario 'view answers to question', :js do
    visit question_path(question)
    expect(page).to have_content(question.body)

    expect(page).to have_content(question.answers[0].body)
  end
end
