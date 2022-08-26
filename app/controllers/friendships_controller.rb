class FriendshipsController < ApplicationController
  include FriendRequestsHelper

  def create
    friend = User.find(params[:friend_id])
    current_user.friends.create(friend_id: friend.id)

    delete_friend_request(friend)
    friend.friends.create(friend_id: current_user.id)
  end
end
