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

    it 'callig friend from friend will return the value from friend_id instead of user_id' do
      user = User.create(name: 'first user', email: 'first@gmail.com', password: 'password')
      user2 = User.create(name: 'second user', email: 'second@gmail.com', password: 'password')

      user.friendships.create(friend_id: user2.id, status: 'pending')

      expect(user.friendships.last.friend.name).to eq('second user')
    end

    it 'from friends calling user will return the owner and friend will be friend_id' do
      user = User.create(name: 'first user', email: 'first@gmail.com', password: 'password')
      user2 = User.create(name: 'second user', email: 'second@gmail.com', password: 'password')

      friend_entry = user.friendships.create(friend_id: user2.id, status: 'pending')

      expect(friend_entry.user.name).to eq('first user')
      expect(friend_entry.friend.name).to eq('second user')
    end

    it 'accepted request' do
      user = User.create(name: 'first user', email: 'first@gmail.com', password: 'password')
      user2 = User.create(name: 'second user', email: 'second@gmail.com', password: 'password')

      user.friendships.create(friend_id: user2.id, status: 'accepted')

      expect(user.friendships.accepted.size).to eq(1)
    end

    it 'pending requests' do
      user = User.create(name: 'first user', email: 'first@gmail.com', password: 'password')
      user2 = User.create(name: 'second user', email: 'second@gmail.com', password: 'password')

      user.friendships.create(friend_id: user2.id, status: 'pending')

      expect(user.friendships.pending.size).to eq(1)
    end
  end
end
