class FriendshipsController < ApplicationController
  include FriendRequestsHelper

  before_action :verify_friend_req

  def create
    # Only the friendreq receiver can 'create' a friendship
    current_user.friends.create(friend_id: @sender.id)
    @sender.friends.create(friend_id: current_user.id)

    @friend_req.delete
    redirect_back fallback_location: root_path
  end

  private

  def verify_friend_req
    @sender = User.find(params[:sender_id])
    @friend_req = current_user.received_friend_reqs.find_by(sender_id: @sender.id)
    redirect_to root_url unless @friend_req
  end
end
