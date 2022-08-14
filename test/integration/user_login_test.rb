require "test_helper"

class UserLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get login_path
    assert_response :success

    post login_path, params: {
      session: {
        email: "",
        password: ""
      }
    }
    assert_response :unprocessable_entity
    assert_not flash.empty?
  end

  test "login with valid information" do
    get login_path
    assert_response :success

    post login_path, params: {
      session: {
        email: "darpan@darpan.com",
        password: "foobar"
      }
    }
    assert_response :redirect
    assert_equal users(:Darpan).id, session[:user_id]
  end
end
