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

    scenario 'edits his answer with attached files', :js do
      within '.answers' do
        fill_in answer[body], with: 'edited answer'
        attach_file 'answer_files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on 'Save'

        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end
  end

  describe 'with attached files' do
    background do
      sign_in author
      answer.files.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'temp.txt')), filename: 'temp.txt', content_type: 'text/txt')
      visit question_path(question)
      click_on 'Edit answer'
    end

    scenario 'can add files to his question', :js do
      within '.answers' do
        attach_file 'answer_files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on 'Save'

        expect(page).to have_link 'spec_helper.rb'
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'temp.txt'
      end
    end

    scenario 'can delete attached files', :js do
      within '.answers' do
        click_on 'Delete file'
        page.driver.browser.switch_to.alert.accept

        expect(page).not_to have_link '1.txt'
      end
    end
  end
end
