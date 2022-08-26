module FriendRequestsHelper
  def delete_friend_request(sender)
    current_user.received_friend_reqs.delete_by(sender_id: sender.id)
  end
end
