# frozen_string_literal: true

require 'rails_helper'

feature 'User create answer' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'create answer' do
      fill_in 'Body', with: 'answer answer answer'
      click_on 'Create answer'

      expect(page).to have_content 'Answer was succesfully created'
      expect(page).to have_content 'answer answer answer'
    end

    scenario 'create answer with errors' do
      click_on 'Create answer'
      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to ask a question' do
    visit question_path(question)
    click_on 'Create answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end