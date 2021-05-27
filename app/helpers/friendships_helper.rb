module FriendshipsHelper

    def friend_user_links(user)
        return if user.id == current_user.id
        friend = current_user.friendships.find_by(friend_id: user.id)
        if friend.nil?
            link_to("Add Friend", user_friendships_path(user_id: current_user.id, friend_id: user.id, status: 'pending', location: users_path), method: :post, class:'btn btn-outline-info btn-sm')
        elsif friend.status == 'pending'
            link_to('Pending friend request! Delete it?', user_friendship_path(user_id:current_user.id, id: friend.id, location: users_path), method: :delete, class:'btn btn-outline-warning btn-sm') 
        else
           link_to('Delete Friend!', user_friendship_path(user_id:current_user.id, id: friend.id, location: users_path), method: :delete, class:'btn btn-outline-danger btn-sm')
        end
    end
end
