# frozen_string_literal: true

require 'rails_helper'

feature 'User create answer' do
  given(:author) { create(:user) }
  given!(:question) { create(:question) }

  describe 'Authenticated user' do
    background do
      sign_in(author)

      visit question_path(question)
    end

    scenario 'create answer', :js do
      fill_in 'Your answer', with: 'Create new answer'
      click_on 'Create answer'

      expect(current_path).to eq question_path(question)
      within '.answers' do
        expect(page).to have_content 'Create new answer'
      end
    end

    scenario 'create answer with errors', :js do
      click_on 'Create answer'
      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to ask a question', :js do
    visit question_path(question)

    expect(page).not_to have_link 'Create answer'
  end
end
