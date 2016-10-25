require 'test_helper'

class LayoutLinksTest < ActionDispatch::IntegrationTest
  def setup
    @basic = users(:basic)
    @admin = users(:admin)
  end

  test "logged in basic navbar displays" do
    log_in_as @basic, 'basic'
    assert is_logged_in?
    get root_path
    assert_template 'welcome'
    # check links
    assert_select 'a', 'Users'
  end

  test "logged out navbar has login" do
    # for some reason is_logged_in? requires log_out to "know" methods
    log_out
    assert_not is_logged_in?
    get root_path
    assert_template 'welcome'
    assert_select 'a', 'Log in'
    assert_select 'a', { count: 0, text: 'Users' }
  end

  test "logged in admin has edit on editable pages" do
    log_in_as @admin, 'admin'
    assert is_logged_in?
    get root_path
    assert_template 'welcome'
    assert_select 'a', { count: 1, text: 'Edit Page' }
    get about_path
    assert_template 'about'
    assert_select 'a', { count: 1, text: 'Edit Page' }
    get contact_path
    assert_template 'contact'
    assert_select 'a', { count: 1, text: 'Edit Page' }
    get users_path
    assert_template 'users/index'
    assert_select 'a', { count: 0, text: 'Edit Page' }
    log_out
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'welcome'
    assert_select 'a', { count: 0, text: 'Edit Page' }
  end
end
