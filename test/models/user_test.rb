require 'test_helper'

class UserTest < ActiveSupport::TestCase

  #where is the teardown for saving users into the db?
  def setup
    @user = User.new name: "Andres Fresnedo", email: "andfresnedo@gmail.com",
                      password: "foobar", password_confirmation: "foobar"
  end

  test "should be valid" do
    assert @user.valid?
  end

  #VERY IMPORTANT LEARNING MOMENT HERE
  #first of all, went to user.rb first to code before writing test so
  # instinct is off
  #second of all wrote this entire snippet of code not understanding the
  # nature of the test: testing that something wrong (blank) should be
  # reported as wrong...this allows the test to fail NOW because we know
  # there is no validity test so it'll in fact say its valid when our test
  # knows that it should not be; THIS IS IMPORTANT because it allows for
  # well designed and intelligent test creation from the beginning in TDD
  # tests that will endure development time instead of just being crappy
  # token tests to satisfy some simple development method and nothing else
  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  #here, unlike previously, hartl decides to seperate his
  # tests to follow a more traditional one assert per test
  #previously, in integration tests, the assert itself had
  # information about what went wrong whereas here it just
  # says that it expects a non-truth value from @user.valid?
  # so you can see that both this test and name presence test
  # would be indistinguishable in minitest readout...so there you
  # go, write one assert per test when you can't tell the difference
  # otherwise group them in some logical organization
  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  #once again i fail to write these tests from the proper perspective
  #i think some of it is the lack of willingness to create a bad object in
  # here...which is weird, because i setup the bad data in the other unit
  # tests...do i not see these as unit tests even though its a TestCase?
  #name should not be so long it ruins the website display
  test "name should not be too long" do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  #email should not be so long it doesn't fit in the db
  test "email should not be too long" do
    @user.email = 'a' * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid emails" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      #why .inspect a string? note optional second arguement to associate
      # with error message is espiecally useful here because of the for-loop
      # but then this begs the question of why not using a second arguement
      # to differeniate between name/email presence/length tests?
      assert @user.valid?, "#{valid_address} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    #use Rubular to tackle the foo.@bar.com problem
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
    @user.save #now the db should save it as lowercase
    assert_equal mixed_case_email.downcase, @user.reload.email
    #reloading above because we want the user to get the db's version
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
    assert_not @user.authenticated?('')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

end
