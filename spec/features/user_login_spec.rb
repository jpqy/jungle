require "rails_helper"
require "images"

RSpec.feature "Visitor can login", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!(
      first_name: "John",
      last_name: "Doe",
      email: "john@doe.com",
      password: "password",
      password_confirmation: "password",
    )
  end

  scenario "They can visit the login page" do
    visit login_path

    # VERIFY
    expect(page).to have_field "email"
    expect(page).to have_field "password"
  end
end
