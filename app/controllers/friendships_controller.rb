class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @user = User.find(current_user.id)
    @friendship = @user.frienships.new(friend_id: params[:friend_id], status: 'pending')

    if @friendship.save
      redirect_to users_path, notice: 'You sent a friend request'
    else
      redirect_to users_path, alert: 'Friend request could not be sent'
    end
  end
end
