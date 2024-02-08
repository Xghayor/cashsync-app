require 'rails_helper'

RSpec.describe Entity, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      group = user.groups.create(name: 'Example Group', icon: 'www.example.com')
      entity = group.entities.new(
        name: 'Entity Name',
        amount: 20.5
      )
      entity.author = user
      expect(entity).to be_valid
    end

    it 'is not valid without a name' do
      user = User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      group = user.groups.create(name: 'Example Group', icon: 'www.example.com')
      entity = group.entities.new(amount: 20.5)
      expect(entity).to_not be_valid
      expect(entity.errors[:name]).to include("can't be blank")
    end

    it 'is not valid without an amount' do
      user = User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      group = user.groups.create(name: 'Example Group', icon: 'www.example.com')
      entity = group.entities.new(name: 'Entity Name')
      expect(entity).to_not be_valid
      expect(entity.errors[:amount]).to include("can't be blank")
    end

    it 'is not valid with a negative amount' do
      user = User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      group = user.groups.create(name: 'Example Group', icon: 'www.example.com')
      entity = group.entities.new(name: 'Entity Name', amount: -5)
      expect(entity).to_not be_valid
      expect(entity.errors[:amount]).to include('must be greater than or equal to 0')
    end
  end

  describe 'associations' do
    it 'belongs to an author (User)' do
      expect(Entity.reflect_on_association(:author).macro).to eq(:belongs_to)
      expect(Entity.reflect_on_association(:author).class_name).to eq('User')
    end

    it 'belongs to a group' do
      expect(Entity.reflect_on_association(:group).macro).to eq(:belongs_to)
    end
  end

  describe 'most_recent_entities' do
    it 'returns entities ordered by most recent created_at' do
      user = User.create(
        name: 'John Doe',
        email: 'john@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      group = user.groups.create(name: 'Example Group', icon: 'www.example.com')
      entity1 = group.entities.create(name: 'Entity 1', amount: 10, author: user)
      entity2 = group.entities.create(name: 'Entity 2', amount: 15, author: user)

      expect(group.entities.most_recent_entities).to eq([entity2, entity1])
    end
  end
end
