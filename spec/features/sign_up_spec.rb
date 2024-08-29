# frozen_string_literal: true

require 'rails_helper'

feature 'User sign up in application' do
  scenario 'Tries to sign up' do
    visit new_user_registration_path

    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: 11_111_111
    fill_in 'Password confirmation', with: 11_111_111
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
