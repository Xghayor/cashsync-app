# rubocop:disable all
require 'rails_helper'

RSpec.feature 'Users auth', type: :feature do
  let(:user) do
    User.create!(
      name: 'test-name',
      email: 'test@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
  end

  scenario 'logs in with valid credentials' do
    visit_new_user_session_path_and_log_in(user)

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_current_path(authenticated_root_path)
  end

  scenario 'logs in with invalid credentials' do
    visit_new_user_session_path_and_log_in_with_invalid_credentials

    expect(page).to have_content('Invalid Email or password')
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'User clicks "Forgot password?" link' do
    visit_new_user_session_path_and_click_forgot_password_link

    expect(page).to have_content('Forgot your password?')
    expect(page).to have_current_path(new_user_password_path)
  end

  scenario 'User clicks back button' do
    visit_new_user_session_path_and_click_back_button

    expect(page).to have_current_path(root_path)
  end

  private

  def visit_new_user_session_path_and_log_in(user)
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password123'

    click_button 'Log in'
  end

  def visit_new_user_session_path_and_log_in_with_invalid_credentials
    visit new_user_session_path

    fill_in 'Email', with: 'invalid@example.com'
    fill_in 'Password', with: 'wrongpassword'

    click_button 'Log in'
  end

  def visit_new_user_session_path_and_click_forgot_password_link
    visit new_user_session_path

    click_link 'Forgot password?'
  end

  def visit_new_user_session_path_and_click_back_button
    visit new_user_session_path

    click_link '<'
  end
end
