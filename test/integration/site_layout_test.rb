require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:Darpan)
  end

  test 'root' do
    get root_path
    assert_response :redirect

    post login_path, params: {
      session: {
        email: @user.email,
        password: "foobar"
      }
    }

    get root_path
    assert_response :success
    assert_template 'users/index'

    assert_select 'main a', count: User.count
    assert_select 'a[href=?]', user_path(@user)
  end

  test 'user#show' do
    post login_path, params: {
      session: {
        email: @user.email,
        password: "foobar"
      }
    }

    get user_path(@user)
    assert_response :success

    assert_select 'p', "Name: #{@user.first_name}"
    assert_select 'p', "Email: #{@user.email}"
    assert_select 'li p', "Name: #{users(:Avash).first_name}"
    assert_select 'li button', 'Accept'
    assert_select 'li button', 'Reject'

    get user_path(users(:Avash))
    assert_select 'button', count: 2

    # Login as other user and check what he sees
    post login_path, params: {
      session: {
        email: users(:Avash).email,
        password: "foobar"
      }
    }
    get user_path(@user)
    assert_response :success
    assert_select 'h3', 'Friendship Status'
    assert_select 'p', text: 'Pending....'
  end
end
