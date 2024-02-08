require 'rails_helper'

RSpec.feature 'Transaction Management', type: :feature do
  scenario 'User views the transactions page for a group' do

    user = User.create!(
      name: 'John Doe',
      email: 'john@example.com',
      password: 'password123'
    )

    group = user.groups.create!(name: 'Example Group', icon: 'nil.png')


    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password123'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')

    visit user_group_entities_path(user_id: user.id, group_id: group.id)

    expect(page).to have_content('Transactions')

    entity1 = group.entities.create!(name: 'Entity 1', amount: 20.5, author: user)
    entity2 = group.entities.create!(name: 'Entity 2', amount: 15.75, author: user)

    expect(page).to have_css(".total-amount p", text: 'Total Amount')

    expect(page).to have_link('Add a New Transaction', href: new_user_group_entity_path(user, group), class: 'add-transaction-btn')
  end
end
