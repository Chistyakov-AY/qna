# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete answer' do
  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given(:question) { create(:question, author:) }
  given!(:answers) { create(:answer, question:, author:) }

  describe 'Authenticated user' do
    scenario 'Author delete his answer' do
      sign_in(author)
      visit question_path(question)

      click_on 'Delete answer'

      expect(page).to have_content 'Your answer successfully destroy!'
    end

    scenario 'Another author delete answer' do
      sign_in(user)
      visit question_path(question)
      click_on 'Delete answer'

      expect(page).to have_content 'Only author can delete this answer!'
    end
  end
end
