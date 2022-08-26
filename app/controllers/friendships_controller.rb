class FriendshipsController < ApplicationController
  include FriendRequestsHelper

  def create
    # Only the friendreq receiver can 'create' a friendship
    sender = User.find(params[:sender_id])
    current_user.friends.create(friend_id: sender.id)

    delete_friend_request(sender)
    sender.friends.create(friend_id: current_user.id)
  end
end
