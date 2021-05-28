module FriendshipsHelper

    def friend_user_links(user)
        return if user.id == current_user.id
        asn = friends?(current_user,user)
        if asn.nil?
            link_to("Add Friend", user_friendships_path(user_id: current_user.id, friend_id: user.id, status: 'pending', location: users_path), method: :post, class:'btn btn-outline-info btn-sm')
        elsif asn.status == 'pending' && asn.user_id == current_user.id
            link_to('Pending friend request! Delete it?', user_friendship_path(user_id: asn.user_id, id: asn.id, location: users_path), method: :delete, class:'btn btn-outline-warning btn-sm') 
        elsif asn.status == 'pending' && asn.friend_id == current_user.id
            link_to('Accept!', inviteaccepted_path(id: asn.id, status: 'accepted', location: users_path), method: :patch, class:'btn btn-outline-success btn-sm mx-3')
        else
           link_to('Delete Friend!', user_friendship_path(user_id:asn.user_id, id: asn.user_id, location: users_path), method: :delete, class:'btn btn-outline-danger btn-sm')
        end
    end

end
