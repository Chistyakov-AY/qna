# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign in', '
  In order to ask question
  As an unauthenticated user
  Id like to be able to sign in
' do
  given(:user) { create(:user) } # alias let

  background { visit new_user_session_path } # alias before

  scenario 'Registred user tries to sign in' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content 'All questions:'
  end

  scenario 'Unregistred user tries to sign in' do
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
  end
end
