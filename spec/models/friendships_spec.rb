require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'Friendships' do
    it 'User have many friends' do
      user = User.create(name: 'first user', email: 'first@gmail.com', password: 'password')
      user2 = User.create(name: 'second user', email: 'second@gmail.com', password: 'password')
      user3 = User.create(name: 'third user', email: 'third@gmail.com', password: 'password')

      user.friendships.create(friend_id: user2.id, status: 'pending')
      user.friendships.create(friend_id: user3.id, status: 'pending')

      expect(user.friendships.size).to eq(2)
      expect(user2.friendships.size).to eq(0)
    end
  end
end
