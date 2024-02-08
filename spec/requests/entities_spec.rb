require 'rails_helper'

RSpec.describe "Entities", type: :request do
  describe "GET /index" do
    it "renders the index page with a list of entities" do
      # Create a user and sign in (you can modify this based on your authentication logic)
      user_params = {
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      }
      user = User.create(user_params)
      sign_in user
      
      group = user.groups.create(name: 'Example Group', icon: "www.example.com")
      entity = group.entities.create(name: 'Entity Name', amount: 20.5)

      # Perform the request to the index action
      get user_group_entities_path(user, group)

      expect(response).to have_http_status(200)
      expect(response.body).to include('Transactions')
      expect(response.body).to include('Add a New Transaction')
    end
  end
end
