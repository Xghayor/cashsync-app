require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = User.new(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to be_valid
    end

    it "is not valid without a name" do
      user = User.new(
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to_not be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end
  end

  describe "associations" do
    it "has many entities" do
      user = User.new(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to respond_to(:entities)
    end

    it "has many groups" do
      user = User.new(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user).to respond_to(:groups)
    end
  end

  describe "devise modules" do
    it "includes database_authenticatable module" do
      expect(User.devise_modules).to include(:database_authenticatable)
    end

    it "includes registerable module" do
      expect(User.devise_modules).to include(:registerable)
    end

    it "includes recoverable module" do
      expect(User.devise_modules).to include(:recoverable)
    end

    it "includes rememberable module" do
      expect(User.devise_modules).to include(:rememberable)
    end

    it "includes validatable module" do
      expect(User.devise_modules).to include(:validatable)
    end
  end
end
