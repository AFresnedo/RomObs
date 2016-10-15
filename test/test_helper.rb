ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"

# for improved test result output
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

  # i believe the following tests are for unit tests

  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as user
    session[:user_id] = user.id
  end

end

class ActionDispatch::IntegrationTest

  def is_logged_in?
    !session[:user_id].nil?
  end

  # create a logged in user with a fixture in integration tests
  # some fixtures have custom passwords
  def log_in_as(user, password = 'password', remember_me = '1', admin = '0')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me,
                                          admin: admin} }
  end

  def log_out_fixture
    delete logout_path
  end

end
