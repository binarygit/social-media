require "test_helper"

class UserFriendshipsTest < ActionDispatch::IntegrationTest

  test 'user can become friends' do
    login_as users(:Darpan)

    assert_difference ->{ Friendship.count } => 2, ->{ FriendRequest.count } => -1 do
      post friendships_path, params: {
        sender_id: users(:Avash).id
      }
    end

    # If there's no existing friend req, users cannot become friends
    login_as users(:Kritesh)

    assert_no_difference [ 'Friendship.count', 'FriendRequest.count' ]  do
      post friendships_path, params: {
        sender_id: users(:Avash).id
      }
    end
  end
end
