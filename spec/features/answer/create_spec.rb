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

    scenario 'create answer with attached file', :js do
      fill_in 'Your answer', with: 'Answer,answer,answer'
      # save_and_open_page
      attach_file 'Files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Create answer'

      within '.answers' do
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end
  end

  scenario 'Unauthenticated user tries to ask a question', :js do
    visit question_path(question)

    expect(page).not_to have_link 'Create answer'
  end
end
