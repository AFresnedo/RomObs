require 'test_helper'

class LayoutLinksTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:andres)
  end

  test "logged in navigating" do
    log_in_as @user
    get root_path
    get about_path
  end

  test "logged out navigating" do
    log_out_fixture
    assert_not is_logged_in?
    get root_path
    assert_template 'home'
    get about_path
    assert_template 'about'
    # this template assert requires at least 1 about page article fixture
    assert_template 'articles/_article'
  end
end
