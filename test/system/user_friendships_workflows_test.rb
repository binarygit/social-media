require "application_system_test_case"

class UserFriendshipsWorkflowsTest < ApplicationSystemTestCase
  def setup
    visit root_url

    fill_in "Email", with: users(:Darpan).email
    fill_in "Password", with: "foobar"
    click_button "Login"
  end

  test "Sending a friend request" do
    visit user_path(users(:Kritesh))

    assert_selector "h3", text: "Friendship Status"
    find_button("Add Friend").click

    assert_selector "p", text: "Pending...."
  end

  test "Accepting a friend request" do
    visit user_path(users(:Darpan))

    assert_selector "h3", text: "Pending Requests"
    assert_selector "#pending_requests li", count: 1
    find_button("Accept").click
    assert_selector "#pending_requests li", count: 0
  end
end
