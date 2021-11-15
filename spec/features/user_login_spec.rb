# frozen_string_literal: true

require 'rails_helper'
require 'images'

RSpec.feature 'Visitor can login', type: :feature, js: true do
  # SETUP
  before :each do
    @user = User.create!(
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@doe.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  scenario 'They can visit the login page' do
    visit login_path

    # VERIFY
    expect(page).to have_field 'email'
    expect(page).to have_field 'password'
  end

  scenario 'Incorrect login results in an alert' do
    visit login_path
    expect(page).to have_field 'email'

    # Fill in field with wrong credentials
    fill_in 'email', with: 'john@doe.com'
    fill_in 'password', with: 'wrongpass'
    click_button 'Login'

    expect(page).to have_css '.alert'
  end

  scenario 'Correct login results in change in header for logged in context' do
    visit login_path
    expect(page).to have_field 'email'

    # Fill in field with correct credentials
    fill_in 'email', with: 'john@doe.com'
    fill_in 'password', with: 'password'
    click_button 'Login'

    # See name and Logout in nav bar
    within 'nav' do
      expect(page).to have_text 'Logout'
      expect(page).to have_text @user.first_name
    end
  end
end
