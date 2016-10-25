require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new name: "Andres Fresnedo", email: "andfresnedo@gmail.com",
                      password: "foobar", password_confirmation: "foobar",
                      activated: "yes", activation_digest: User.digest("foobar")
    # all blog fixtures assigned to blogger
    @blogger = users(:blogger)
    @complete = users(:complete)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = 'a' * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid emails" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "emails should be unique" do
    dupUser = @user.dup
    @user.save
    dupUser.email = @user.email.upcase
    assert_not dupUser.valid?
  end

  test "emails should be stored in all lowercase" do
    mixed_case_email = "tooDleoOO@toDDLES.OrG"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password shouldn't be blank" do
    blank_password = " " * 8
    @user.password = @user.password_confirmation = blank_password
    assert_not @user.valid?
  end

  test "password should be at least 6 characters" do
    short_password = "a" * 5
    @user.password = @user.password_confirmation = short_password
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('remember', '')
  end

  test "authenticated? false return on activated check with invalid token" do
    assert_not @user.authenticated?('activation', '')
  end

  test "authenticated? true return on activated check with valid token" do
    assert @user.authenticated?('activation', 'foobar')
  end

  test "not admin" do
    assert_not @user.admin?
  end

  test "not blogger" do
    assert_not @user.blogger?
  end

  test "dependent blogs are destroyed" do
    # do not use blogger, all blogs assigned to him
    user = @complete
    user.blogs.create!(title: 'title', descript: 'hi', body: 'eh', topic: 'hm')
    assert_difference 'Blog.count', -1 do
      user.destroy
    end
  end

end
