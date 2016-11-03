require 'test_helper'

class BasicPageEditTest < ActionDispatch::IntegrationTest
  # this integration test ensures that all the edit features are displayed on
  # the basic pages when/only when an admin is logged in and browsing them
  def setup
    @basic = users(:basic)
    @admin = users(:admin)
  end

  test "basic user doesnt see admin features" do
    # example of hardcoding login instead of using helper
        post login_path, params: { session: { email: @basic.email,
                                          password: "basic" } }
    assert is_logged_in?
    assert_not @basic.admin?
    get about_path
    assert_template 'about'
    assert_template 'articles/_article'
    # .articles is the css selector for class articles
    assert_select '.container' do
      assert_select 'h3', "First Article"
    end
    get about_edit_path
    assert_response :redirect
    get contact_edit_path
    assert_response :redirect
  end

  test "admin user sees view and edit modes in about page" do
    assert @admin.admin?
    # login with password 'admin' and remember flag on
    log_in_as(@admin, 'admin', '1')
    assert is_logged_in?
    get about_path
    assert_template 'about'
    assert_select '.container' do
      assert_select 'h3', "First Article"
      assert_select 'span'
      assert_select '.article-content' do
        assert_select 'a', 0
      end
    end
    get about_edit_path
    assert_response :success
    assert_select '.container' do
      assert_select 'h3', "First Article"
      assert_select 'span'
      assert_select '.article-content' do
        assert_select 'a'
      end
    end
    # ensure mode lock after logout
    log_out
    get about_edit_path
    assert_response :redirect
  end

  test "admin user sees view and edit modes in contact page" do
    assert @admin.admin?
    # login with password 'admin' and remember flag on
    log_in_as(@admin, 'admin', '1')
    assert is_logged_in?
    get contact_path
    assert_template 'contact'
    assert_select '.container' do
      assert_select 'h3'
      assert_select '.article-content' do
        assert_select 'a', 0
      end
    end
    get contact_edit_path
    assert_response :success
    assert_select '.container' do
      assert_select 'h3', 'contact'
      assert_select '.article-content' do
        assert_select 'a'
      end
    end
    # ensure mode lock after logout
    log_out
    get about_edit_path
    assert_response :redirect
  end
end
