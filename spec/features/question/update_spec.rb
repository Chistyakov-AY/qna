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

    scenario 'edits his question with attached files', :js do
      attach_file 'question_files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Save'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  describe 'with attached files' do
    background do
      sign_in(author)
      question.files.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'temp.txt')), filename: 'temp.txt', content_type: 'text/txt')
      visit question_path(question)
      click_on 'Edit question'
    end

    scenario 'can add files to his question', :js do
      within '.question' do
        attach_file 'question_files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on 'Save'

        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
        expect(page).to have_link 'temp.txt'
      end
    end

    scenario 'can delete attached files', :js do
      within '.question' do
        click_on 'Delete file'
        page.driver.browser.switch_to.alert.accept

        expect(page).not_to have_link 'temp.txt'
      end
    end
  end

  scenario 'Unauthenticated user tries update a question' do
    visit question_path(question)

    expect(page).not_to have_link 'Update question'
  end
end
