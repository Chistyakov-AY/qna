# frozen_string_literal: true

require 'rails_helper'

feature 'User can view the list of questions' do
  given(:author) { create(:user) }
  given!(:questions) { create_list(:question, 3, author:) }

  scenario 'views the list of all questions', :js do
    visit questions_path

    questions.each do |question|
      expect(page).to have_content(question.title)
    end
  end
end
