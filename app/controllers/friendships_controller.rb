class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend_id])
    current_user.friends.create(friend_id: friend.id)
    friend.friends.create(friend_id: current_user.id)
  end
end
