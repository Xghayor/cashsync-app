require 'rails_helper'

RSpec.feature 'Category Management', type: :feature do
  scenario 'User logs in and views the category page with groups' do
    user = User.create!(
      name: 'John Doe',
      email: 'john@example.com',
      password: 'password123'
    )

    group1 = user.groups.create!(name: 'Group 1', icon: 'nil.png')
    group2 = user.groups.create!(name: 'Group 2', icon: 'nil2.png')

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')

    visit user_groups_path(user)

    expect(page).to have_content('CATEGORIES')
  end

  scenario 'User views the category page with groups and images' do
    user = User.create!(
      name: 'John Doe',
      email: 'john@example.com',
      password: 'password123'
    )

    group1 = user.groups.create!(name: 'Group 1', icon: 'nil.png')
    group2 = user.groups.create!(name: 'Group 2', icon: 'nil2.png') # No icon for this group

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')

    visit user_groups_path(user)

    expect(page).to have_content('CATEGORIES')

    [group1, group2].each do |group|
      expect(page).to have_css(".category-item img")
    end
  end

  scenario 'User views the category page with groups and checks the "Add a Category" button' do
    user = User.create!(
      name: 'John Doe',
      email: 'john@example.com',
      password: 'password123'
    )

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')

    visit user_groups_path(user)

    expect(page).to have_content('CATEGORIES')

    expect(page).to have_link('Add a Category', href: new_user_group_path(user))
  end
end
