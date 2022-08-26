ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  # Log in as a particular user.
  def login_as(user, password: 'foobar')
    post login_path, params: { session: { email: user.email,
                                          password: password } }
  end

  def send_friend_req(user)
    post friend_requests_path, params: {
      receiver_id: user.id
    }
  end
end
