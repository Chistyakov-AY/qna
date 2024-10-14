# frozen_string_literal: true

require 'rails_helper'

feature 'Author can choose the best answer' do
  given(:question_author) { create(:user) }
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: question_author) }
  given!(:answers) { create_list(:answer, 3, question:, author: user) }

  scenario "Not question's author tries to choose the best answer", :js do
    sign_in user
    visit question_path(question)

    expect(page).not_to have_link 'Best answer'
  end

  describe "Question's author" do
    background do
      sign_in question_author
      visit question_path(question)
    end

    scenario 'can choose the best answer', :js do
      page.find(:css, "a#best_answer_#{answers[0].id}").click
      page.find(:css, "#check_best_answer_#{answers[0].id}").set(true)
      page.find_button("confirm_#{answers[0].id}").click

      expect(page).to have_css('.best')
    end

    scenario 'Only one best answer', :js do
      page.find(:css, "a#best_answer_#{answers[0].id}").click
      page.find(:css, "#check_best_answer_#{answers[0].id}").set(true)
      page.find_button("confirm_#{answers[0].id}").click

      page.find(:css, "a#best_answer_#{answers[1].id}").click
      page.find(:css, "#check_best_answer_#{answers[1].id}").set(true)
      page.find_button("confirm_#{answers[1].id}").click

      best_answer = page.find(:css, '.best')

      expect(best_answer).to have_content(answers[1].body)
    end

    scenario 'Best answer should be first on the page', :js do
      page.find(:css, "a#best_answer_#{answers[1].id}").click
      page.find(:css, "#check_best_answer_#{answers[1].id}").set(true)
      page.find_button("confirm_#{answers[1].id}").click

      within '.answers' do
        first_answer_on_page = page.all(:css, '.answer_list').first
        expect(first_answer_on_page).to have_content(answers[1].body)
      end
    end
  end
end
