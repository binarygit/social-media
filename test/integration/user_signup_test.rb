require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest
  test "signup with invalid information" do
    get signup_path
    assert_response :success

    assert_no_difference 'User.count' do
      post users_path, params: { 
                         user: {
                           first_name: "",
                           last_name: "",
                           email: "",
                           password: ""
                         }
                       }
      assert_response :unprocessable_entity
      assert_template 'users/new'
      assert_select '#error_explanation'
      assert_select '#error_explanation li', count: 4
    end
  end

  test "signup with valid information" do
    get signup_path
    assert_response :success

    assert_difference 'User.count' do
      post users_path, params: { 
                         user: {
                           first_name: "Avi",
                           last_name: "Bhurtel",
                           email: "avi@avi.com",
                           password: "foobar"
                         }
                       }
    end
  end
end
