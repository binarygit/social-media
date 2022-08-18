require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:Darpan)
  end

  test "login with invalid information" do
    get login_path
    assert_response :success
    assert_template "sessions/new"

    post login_path, params: {
      session: {
        email: "",
        password: ""
      }
    }
    assert_template "sessions/new"
    assert_response :unprocessable_entity
    assert_not flash.empty?
  end

  test "login with valid information" do
    get login_path
    assert_response :success

    post login_path, params: {
      session: {
        email: @user.email,
        password: "foobar"
      }
    }
    assert_response :redirect
    assert_equal @user.id, session[:user_id]

    # Logout test
    delete logout_path
    assert_nil session[:user_id]
    assert_not flash.empty?
  end
end
