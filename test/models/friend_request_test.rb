require "test_helper"

class FriendRequestTest < ActiveSupport::TestCase
  def setup
    @darpan = users(:Darpan)
    @avash = users(:Avash)
  end

  test 'listing friend requests' do
    assert_equal 1, @avash.sent_friend_reqs.count
    assert_equal 1, @darpan.received_friend_reqs.count
  end

  test 'friend request is received by the correct user' do
    sent_request = @avash.sent_friend_reqs.first
    receiver_id = @darpan.id
    assert_equal receiver_id, sent_request.receiver_id
  end

  test 'friend request is sent by the correct user' do
    received_request = @darpan.received_friend_reqs.first
    sender_id = @avash.id
    assert_equal sender_id, received_request.sender_id
  end

  test 'user sent a request to another user' do
    assert @avash.sent_friend_reqs.to(@darpan)
    assert_not @darpan.sent_friend_reqs.to(@avash)
  end

  test 'user received a request from another user' do
    assert @darpan.received_friend_reqs.custom_from(@avash)
    assert_not @avash.received_friend_reqs.custom_from(@darpan)
  end
end
