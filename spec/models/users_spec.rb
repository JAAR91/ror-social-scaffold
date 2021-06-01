require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Users' do
    it 'user creation test' do
      User.create(name: 'first user', email: 'first@gmail.com', password: 'password')
      expect(User.all.size).to eq(1)
    end

    it 'email cant be repetead' do
      User.create(name: 'first user', email: 'first@gmail.com', password: 'password')
      User.create(name: 'second user', email: 'first@gmail.com', password: 'password')

      expect(User.all.size).to eq(1)
    end
  end
end
