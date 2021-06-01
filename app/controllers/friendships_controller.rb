class FriendshipsController < ApplicationController
  def index
    @friendships = current_user.friendships.accepted
  end

  def create
    @friend = current_user.friendships.new(friend_id: params[:friend_id], status: 'pending')

    if @friend.save
      redirect_to params[:location], alert: "Friend request sent to #{@friend.friend.name}"
    else
      redirect_to params[:location], alert: 'Friend request cant be sended'
    end
  end

  def frienddecline
    @friendship = Friendship.find(params[:id])
    if params[:friend] == 'delete'
      @n_friendship = current_user.inverted_friendships.find_by(user_id: @friendship.friend_id)
      @friendship.destroy
      @n_friendship.destroy
      redirect_to params[:location], alert: "#{@friendship.friend.name} was removed from your friend list"
    else
      @friendship.destroy
      redirect_to params[:location], alert: 'Friend request refused'
    end
  end

  def friend_request
    @friend_requests = current_user.inverted_friendships.pending
  end

  def friendaccepted
    @friendship = Friendship.find(params[:id])
    @n_friendship = current_user.friendships.new(status: 'accepted', friend_id: @friendship.user_id)
    if @friendship.update(status: 'accepted') && @n_friendship.save
      redirect_to params[:location], alert: 'Friend request accepted'
    else
      redirect_to params[:location], alert: 'Could not process that request'
    end
  end
end
