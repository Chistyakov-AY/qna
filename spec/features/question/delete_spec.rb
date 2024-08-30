# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete question' do
  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given(:question) { create(:question, author:) }

  describe 'Authenticated user' do
    scenario 'Author delete his question' do
      sign_in(author)
      visit question_path(question)
      click_on 'Delete question'

      expect(page).to have_content 'Your question was succesfully destroy!'
    end

    scenario 'Another author delete question' do
      sign_in(user)
      visit question_path(question)
      click_on 'Delete question'

      expect(page).to have_content 'Only author can delete a question!'
    end
  end

  scenario 'Unauthenticated user delete question' do
    visit question_path(question)

    expect(page).not_to have_link 'Delete question'
  end
end
