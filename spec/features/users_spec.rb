require 'rails_helper'

RSpec.feature 'User Authentication', type: :feature do
  let(:user) do
    User.create!(
      name: 'test-name',
      email: 'test@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
  end

  scenario 'User logs in with valid credentials' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password123'

    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_current_path(authenticated_root_path)
  end

  scenario 'User logs in with invalid credentials' do
    visit new_user_session_path

    fill_in 'Email', with: 'invalid@example.com'
    fill_in 'Password', with: 'wrongpassword'

    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password')
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'User clicks "Forgot password?" link' do
    visit new_user_session_path

    click_link 'Forgot password?'

    expect(page).to have_content('Forgot your password?')
    expect(page).to have_current_path(new_user_password_path)
  end

  scenario 'User clicks back button' do
    visit new_user_session_path

    click_link '<'

    expect(page).to have_current_path(root_path)
  end
end
