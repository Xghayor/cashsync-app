require 'rails_helper'

RSpec.feature 'Splash Page', type: :feature do
  scenario 'User visits the splash page' do
    visit root_path

    expect(page).to have_content('CashSync')
  end

  scenario 'Splash page has a title with correct CSS class' do
    visit root_path

    expect(page).to have_css('h1.splash-title', text: 'CashSync')
  end

  scenario 'Splash page has a horizontal line' do
    visit root_path

    expect(page).to have_css('hr')
  end

  scenario 'Splash page has a description' do
    visit root_path

    expect(page).to have_content('Sync. Budget. Thrive.')
  end

  scenario 'Splash page has a "Login" link with correct path' do
    visit root_path

    expect(page).to have_link('Login', href: new_user_session_path)
  end

  scenario 'Splash page has a "Signup" link with correct path' do
    visit root_path

    expect(page).to have_link('Signup', href: new_user_registration_path)
  end
end
