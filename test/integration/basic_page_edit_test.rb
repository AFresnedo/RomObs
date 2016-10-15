require 'test_helper'

class BasicPageEditTest < ActionDispatch::IntegrationTest
  # this integration test ensures that all the edit features are displayed on
  # the basic pages when/only when an admin is logged in and browsing them
  def setup
    @basic = users(:basic)
    @admin = users(:admin)
  end

  test "basic user doesnt see admin features" do
    post login_path, params: { session: { email: @basic.email,
                                          password: "basic" } }
    assert is_logged_in?
    assert_not @basic.admin?
    get about_path
    assert_template 'about'
    assert_template 'articles/_article'
    # .articles is the css selector for class articles
    assert_select '.container' do
      assert_select '.articles' do
        assert_select 'h3', "First Article"
      end
    end
    get about_edit_path
    assert_response :redirect
  end

  test "admin user sees article edit" do
    # for some reason cant get a helper function working for logging in maybe
    # i was misusing log_in_as
    post login_path, params: { session: { email: @admin.email,
                                          password: "admin" } }
    assert is_logged_in?
    get about_path
    assert_template 'about'
    assert_select '.container' do
      assert_select '.articles' do
        assert_select 'h3', "First Article"
        assert_select 'span'
        assert_select '.content', "My name is Johnny Smitherson. I am 957 years old. Hello!"
        assert_select 'a', 0
      end
    end
    get about_edit_path
    assert_response :success
    assert_select '.container' do
      assert_select '.articles' do
        assert_select 'h3', "First Article"
        assert_select 'span'
        assert_select '.content', "My name is Johnny Smitherson. I am 957 years old. Hello!"
        assert_select 'a', 1
      end
    end
    # get contact_path
    # assert_template 'contact'
    # assert_select 'Edit'
  end
end
