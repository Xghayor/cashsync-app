require 'rails_helper'

RSpec.feature 'Categories', type: :feature do
  scenario 'User logs in and views the category page with groups' do
    user = create_and_log_in_user

    user.groups.create!(name: 'Group 1', icon: 'nil.png')
    user.groups.create!(name: 'Group 2', icon: 'nil2.png')

    visit_user_groups_page(user)

    expect(page).to have_content('CATEGORIES')
  end

  scenario 'User views the category page with groups and images' do
    user = create_and_log_in_user
    group1 = user.groups.create!(name: 'Group 1', icon: 'nil.png')
    group2 = user.groups.create!(name: 'Group 2', icon: 'nil2.png')

    visit_user_groups_page(user)

    expect(page).to have_content('CATEGORIES')

    [group1, group2].each do |_group|
      expect(page).to have_css('.category-item img')
    end
  end

  scenario 'User clicks and redirects "Add a Category" button' do
    user = create_and_log_in_user

    visit_user_groups_page(user)

    expect(page).to have_content('CATEGORIES')

    expect(page).to have_link('Add a Category', href: new_user_group_path(user))
  end

  private

  def create_and_log_in_user
    user = User.create!(
      name: 'John Doe',
      email: 'john@example.com',
      password: 'password123'
    )

    log_in_user(user)

    user
  end

  def log_in_user(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
  end

  def visit_user_groups_page(user)
    visit user_groups_path(user)
  end
end
