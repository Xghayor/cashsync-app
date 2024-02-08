require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/sign_in" do
    it "returns a successful response" do
      get "/users/sign_in"
      expect(response).to have_http_status(200)
    end

    it "renders the Devise sign-in template" do
      get "/users/sign_in"
      expect(response).to render_template(:new)
    end
  end
end
