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

  def log_out
    delete logout_path
  end

end

class ActionDispatch::IntegrationTest

  # override log_in_as user for cookie functionality
  def log_in_as(user, password = 'password', remember_me = '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          activated: user.activated,
                                          remember_me: remember_me,
                                          admin: user.admin} }
  end

  # no user browser with cookies, need to emulate this completely?
  # def is_remembered?
    # !cookies[:user_id].nil?
  # end

end
