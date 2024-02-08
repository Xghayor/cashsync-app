require 'rails_helper'

RSpec.describe Group, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      group = user.groups.new(
        name: 'Example Group',
        icon: 'www.example.com'
      )
      expect(group).to be_valid
    end

    it "is not valid without a name" do
      user = User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      group = user.groups.new(icon: 'www.example.com')
      expect(group).to_not be_valid
      expect(group.errors[:name]).to include("can't be blank")
    end

    it "is not valid without an icon" do
      user = User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      group = user.groups.new(name: 'Example Group')
      expect(group).to_not be_valid
      expect(group.errors[:icon]).to include("can't be blank")
    end
  end

  describe "associations" do
    it "belongs to a user" do
      expect(Group.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "has many entities" do
      expect(Group.reflect_on_association(:entities).macro).to eq(:has_many)
    end
  end

  describe "total_transactions_amount" do
    it "returns the sum of amounts for all entities in the group" do
      user = User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      group = user.groups.create(name: 'Example Group', icon: 'www.example.com')
      entity1 = group.entities.create(name: 'Entity 1', amount: 10)
      entity2 = group.entities.create(name: 'Entity 2', amount: 15)

      expect(group.total_transactions_amount).to eq(0.0)
    end

    it "returns 0 if there are no entities in the group" do
      user = User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      group = user.groups.create(name: 'Example Group', icon: 'www.example.com')

      expect(group.total_transactions_amount).to eq(0)
    end
  end
end