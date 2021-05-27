class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.frienships.new(friend_id: params[:friend_id], status: 'pending')

    if @friendship.save
      redirect_to users_path, notice: 'You sent a friend request'
    else
      redirect_to users_path, alert: 'Friend request could not be sent'
    end
  end

  def edit
    @friendship = current_user.friendships.find(params[:id])
  end

  def update
    @friendship = current_user.friendships.find(params[:id])
    
    @friend = @friendship.friend
    @c_friendship = @friend.friendships.new(friend_id: @current_user.id, status: 'accepted')

    if @friendship.update(status: 'accepted') && @c_friendship.save
      flash[:success] = 'Event Updated!'
      redirect_to event_path(@event.id)
    else
      flash.now[:warning] = 'Event Updated!'
      render :edit
    end
  end

end
