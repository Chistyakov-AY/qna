# frozen_string_literal: true

require 'rails_helper'

feature 'User can log out' do
  given(:user) { create(:user) }

  scenario 'Registred user tries to log out' do
    sign_in(user)
    visit questions_path

    click_on 'Log out'

    expect(page).to have_content 'Signed out successfully.'
  end
end
