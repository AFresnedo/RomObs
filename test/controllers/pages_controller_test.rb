require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    get '/home'
    assert_response :success
  end

  test "should get about" do
    get about_path
    assert_response :success
    get about_edit_path
    assert_response :redirect
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    get contact_edit_path
    assert_response :redirect
  end

end
