require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @basic = users(:basic)
  end

  test "should get new" do
    get login_path
    assert_response :success
    assert_template 'sessions/new'
  end

  # TODO figure out if this is possible, no user browser to store cookies in
  test "remember user with cookies" do
    # create session and cookies
    log_in_as(@basic, 'basic', '1')
    assert_redirected_to @basic
    assert is_logged_in?
    # assert is_remembered?
    # clear session
    # assert still logged in because of cookies
  end


  test "logout" do
    log_in_as(@basic, 'basic', '1')
    assert is_logged_in?
    log_out
    assert_not is_logged_in?
  end

end
