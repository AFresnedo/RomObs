require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  # the key to this setup is that "session" is not set
  # in other words, the user is not logged in (but is remembered)
  def setup
    @user = users(:andres)
    remember @user
  end

  test "current user returns correct user when session is nil" do
    assert_equal @user, current_user
    assert is_logged_in? # ensure current_user is not nil
  end

  test "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end
