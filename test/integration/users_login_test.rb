require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:andres)
  end

  # a note about the merit of this test: had written ":sessions" in the login
  # form, resulting in a hard failure when somebody submitted the form but
  # because this integration test passed i immediately knew that the problem
  # had to be in the code in "views", the only thing not validated by this
  # integration test...that's huge, a really big deal for development
  test "login with invalid info" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid info" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email,
                                          password: "password" } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "logout" do
    # TODO wish i could just call another test and continue it
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    # something to learn, it is possible to perform operations not intended by
    # ui design, such as logging out while logged out (chrome and firefox used
    # on the same site at the same time for example)...it is important to write
    # solid code and tests while keeping in mind possibilities not just the
    # standard situations and everything working as intended; i will also note
    # that this kind of predicition comes mostly from experience / awareness
    # and that distractions such as learning through a tutorial and hitting due
    # dates or not being 100% will just...prevent perfection
    delete logout_path # user attempts to re-logout
  end

  test "login with remembering" do
    log_in_as @user
    # test if the "cookies" exists and has the right value
    assert_not_nil cookies['remember_token']
    # test if cookies value matches user's token value
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test "login without remembering" do
    log_in_as @user, remember_me: 0
    assert_nil cookies['remember_token']
  end
end
