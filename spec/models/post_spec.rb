require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Post' do
    it 'a user have many post' do
      @user = User.create(name: 'first user', email: 'first@gmail.com', password: 'password')
      @user.posts.create(content: 'first post')
      @user.posts.create(content: 'second post')
      @user.posts.create(content: 'third post')
      @user.posts.create(content: '4z post')

      expect(@user.posts.size).to eq(4)
      expect(Post.all.size).to eq(4)
    end
  end
end
