require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:andres)
  end

  test "unsuccessful edit" do
    log_in_as @user
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
  end

  test "successful edit" do
    log_in_as @user
    get edit_user_path @user
    assert_template 'users/edit'
    name = "Foo Bar" # new name
    email = "foo@bar.com" # new email
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty? # check for success flash
    assert_redirected_to @user
    @user.reload # get data from db
    assert_equal name, @user.name # ensure new name was entered into the db
    assert_equal email, @user.email # new email now in db
  end
end
