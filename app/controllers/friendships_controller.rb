class FriendshipsController < ApplicationController

  def index
    @friendships = Friendship.accepted.where("user_id = ? OR friend_id = ?", current_user.id, current_user.id)
  end

  def create
    @friend = current_user.friendships.new(friend_id: params[:friend_id], status: 'pending')

    if @friend.save
      redirect_to params[:location], alert: "Friend request sent to #{@friend.friend.name}"
    else
      redirect_to params[:location], alert: 'Friend request cant be sended'
    end
  end

  def destroy
    friend = Friendship.find(params[:id])
    if friend
      friend.destroy
      redirect_to params[:location], alert: 'Friend removed from your friend list'
    else
      redirect_to params[:location], alert: 'You cant remove this friend from your friend list'
    end
  end

  def friend_request
    @friend_requests = Friendship.where(:friend_id => current_user.id, :status => 'pending')
  end

  def update
    @friendship = Friendship.find(params[:id])
    if @friendship.update(status: params[:status])
      redirect_to params[:location], alert: 'Friend request accepted'
    else
      redirect_to params[:location], alert: 'Could process that request'
    end
  end

end
