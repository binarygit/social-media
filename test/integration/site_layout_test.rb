require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:Darpan)
  end

  test 'root' do
    get root_path
    assert_response :redirect

    login_as @user

    get root_path
    assert_response :success
    assert_template 'users/index'

    assert_select 'main a', count: User.count
    assert_select 'a[href=?]', user_path(@user)
  end

  test 'user#show' do
    login_as @user

    get user_path(@user)
    assert_response :success

    assert_select 'p', "Name: #{@user.first_name}"
    assert_select 'p', "Email: #{@user.email}"
    assert_select 'li p', "Name: #{users(:Avash).first_name}"
    assert_select 'li input', value: 'Accept'
    assert_select 'li button', 'Reject'

    get user_path(users(:Avash))
    assert_select 'button', count: 1

    # Login as other user and check what he sees
    login_as users(:Avash)

    get user_path(@user)
    assert_response :success
    assert_select 'h3', 'Friendship Status'
    assert_select 'p', text: 'Pending....'
  end
end
