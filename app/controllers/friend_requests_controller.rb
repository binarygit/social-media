class FriendRequestsController < ApplicationController
  before_action :verify_original_req, only: [:create]

  def create
    current_user.sent_friend_reqs.create!(receiver_id: params[:receiver_id])
    redirect_to user_path(params[:receiver_id])
  end

  private

  def verify_original_req 
    receiver = User.find(params[:receiver_id])

    if current_user.sent_friend_reqs.to(receiver) || receiver.sent_friend_reqs.to(current_user)
      redirect_to user_path(params[:receiver_id])
    end
  end
end
