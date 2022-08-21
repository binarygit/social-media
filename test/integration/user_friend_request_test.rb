require "test_helper"

class UserFriendRequestTest < ActionDispatch::IntegrationTest

  test 'user can send friend requests' do
    post login_path, params: {
      session: {
        email: users(:Kritesh).email,
        password: "foobar"
      }
    }
    
    get user_path(users(:Darpan))
    assert_response :success
    assert_select 'input[type="submit"]', value: "Add Friend"
    assert_difference 'FriendRequest.count' do
    post friend_requests_path, params: {
      receiver_id: users(:Darpan).id
    }
    end

    assert_response :redirect
    follow_redirect!
    assert_template 'users/show'
    assert_select 'p', 'Pending....'
  end
end
