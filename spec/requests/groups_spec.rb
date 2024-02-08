require 'rails_helper'

RSpec.describe "Groups", type: :request do
  describe "GET /" do
    it "creates a confirmed user, signs in, and is redirected to the authenticated root path" do
      user_params = {
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      }
      user = User.create(user_params)
      sign_in user
      get authenticated_root_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('Total Amount')
    end
  end

  describe 'POST /users/:user_id/groups' do
    let(:user_params) {
      {
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      }
    }
    let(:user) { User.create(user_params) }

    before do
      sign_in user
      get user_groups_path(user)
    end

    it 'creates a new group' do
      expect do
        post user_groups_path(user), params: { group: { name: 'Example group', icon: 'www.example.com' } }
      end.to change(Group, :count).by(1)
    end

    it 'redirects to user_groups_path' do
      post user_groups_path(user), params: { group: { name: 'Example group', icon: 'www.example.com' } }
      expect(response).to redirect_to(authenticated_root_path)
    end
  end
end
