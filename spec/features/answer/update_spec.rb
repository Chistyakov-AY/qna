# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit his answer' do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given!(:question) { create :question, author: }
  given!(:answer) { create :answer, author:, question: }

  scenario 'Unauthenticated user can not edit answer', :js do
    visit question_path(question)
    expect(page).not_to have_link 'Edit'
  end

  scenario "user tries to edit other user's answer", :js do
    sign_in user
    visit question_path(question)

    within '.answers' do
      expect(page).not_to have_link 'Edit answer'
    end
  end

  describe 'Authenticated user' do
    background do
      sign_in author
      visit question_path(question)
      click_on 'Edit answer'
    end

    scenario 'edits his answer', :js do
      within '.answers' do
        fill_in answer[body], with: 'edited answer'
        click_on 'Save'

        expect(page).not_to have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).not_to have_selector 'textarea'
      end
    end

    scenario 'edits his answer with errors', :js do
      within '.answers' do
        fill_in answer[body], with: ' '
        click_on 'Save'
        expect(page).to have_selector 'textarea'
      end

      within '.errors' do
        expect(page).to have_content "Body can't be blank"
      end
    end
  end
end
