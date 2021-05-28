module FriendshipsHelper

    def friend_user_links(user)
        return if user.id == current_user.id
        asn = friends?(current_user, user)
        if asn.nil?
            link_to("Add Friend", user_friendships_path(user_id: current_user.id, friend_id: user.id, status: 'pending', location: users_path), method: :post, class:'btn btn-outline-info btn-sm')
        elsif asn.status == 'pending' && asn.user_id == current_user.id
            "<p class='badge bg-info'>Friend request sent</p>".html_safe
        elsif asn.status == 'pending' && asn.friend_id == current_user.id
            render 'friendships/friendform', friend_request: asn, location: users_path
        else
            link_to('Delete Friend!', invitedecline_path(id: asn.id, location: users_path, friend: 'delete'), method: :delete, class:'btn btn-outline-danger btn-sm')
        end
    end
end
