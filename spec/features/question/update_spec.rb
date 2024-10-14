# frozen_string_literal: true

require 'rails_helper'

feature 'User can update question', :js do
  given(:author) { create(:user) }
  given(:question) { create(:question, author:) }

  describe 'Authenticated user' do
    background do
      sign_in(author)

      visit question_path(question)
      click_on 'Edit question'
    end

    scenario 'update question' do
      fill_in 'Title', with: 'Update title'
      fill_in 'Body', with: 'Update body'
      click_on 'Save'

      expect(page).to have_content 'Update title'
      expect(page).to have_content 'Update body'
    end

    scenario 'update question with errors' do
      fill_in 'Title', with: ''
      fill_in 'Body', with: ''
      click_on 'Save'

      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries update a question' do
    visit question_path(question)

    expect(page).not_to have_link 'Update question'
  end
end
