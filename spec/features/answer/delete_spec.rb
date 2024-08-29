require 'rails_helper'

feature 'User can delete answer' do
  given(:user) { create(:user) }
  given(:author) { create(:user)}
  given(:question) { create(:question, author: author) }
  given(:answer) { create(:answer, question: question, author: author) } #ответ есть, но не отображается в форме

  describe 'Authenticated user ' do

    scenario "Author delete his answer" do
      sign_in(author)
      visit question_path(question)
      # byebug
      save_and_open_page

      click_on 'Delete answer'

      expect(page). to have_content 'Your answer was succesfully destroy!'
    end

    scenario "Another author delete answer" do
      sign_in(user)
      visit question_path(question)
      # byebug
      click_on 'Delete answer'

      expect(page). to have_content "Only the author can delete the answer!"
    end
  end
end