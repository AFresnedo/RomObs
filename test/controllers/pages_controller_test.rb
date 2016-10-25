require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get root_path
    assert_response :success
    assert_template 'pages/welcome'
    get '/welcome'
    assert_response :success
    assert_template 'pages/welcome'
  end

  test "should get about" do
    # view mode should be visible but edit mode restricted
    get about_path
    assert_response :success
    assert_template 'pages/about'
    get about_edit_path
    assert_response :redirect, login_url
  end

  test "should get contact" do
    # view mode should be visible but edit mode restricted
    get contact_path
    assert_response :success
    assert_template 'pages/contact'
    get contact_edit_path
    assert_response :redirect, login_url
  end

  test "should get site info" do
    get info_path
    assert_response :success
    assert_template 'pages/info'
    get info_edit_path
    assert_response :redirect, login_url
  end

end
