require "test_helper"

class UserFriendRequestTest < ActionDispatch::IntegrationTest

  test 'user can send friend requests' do
    login_as users(:Kritesh)
    
    get user_path(users(:Darpan))
    assert_select 'input[type="submit"]', value: "Add Friend"

    assert_difference 'FriendRequest.count' do
      send_friend_req(users(:Darpan))
    end

    assert_response :redirect
    follow_redirect!
    assert_template 'users/show'
    assert_select 'p', 'Pending....'
  end

  test 'user can become friends' do
    login_as users(:Darpan)

    assert_difference ->{ Friendship.count } => 2, ->{ FriendRequest.count } => -1 do
    post friendships_path, params: {
      sender_id: users(:Avash).id
    }
    end
  end
end
