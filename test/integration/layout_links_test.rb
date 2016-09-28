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
    # TODO
  end
end
