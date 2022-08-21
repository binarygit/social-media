class FriendRequestsController < ApplicationController
  def create
    receiver = User.find(params[:receiver_id])
    unless current_user.sent_friend_reqs.to(receiver) && receiver.sent_friend_reqs.to(current_user)
      current_user.sent_friend_reqs.create!(receiver_id: params[:receiver_id])
    end
    redirect_to user_path(params[:receiver_id])
  end
end
