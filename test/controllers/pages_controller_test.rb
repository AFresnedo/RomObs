require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    get '/home'
    assert_response :success
  end

  test "should get about" do
    # view mode should be visible but edit mode restricted
    get about_path
    assert_response :success
    get about_edit_path
    assert_response :redirect, login_url
  end

  test "should get contact" do
    # view mode should be visible but edit mode restricted
    get contact_path
    assert_response :success
    get contact_edit_path
    assert_response :redirect, login_url
  end

end
