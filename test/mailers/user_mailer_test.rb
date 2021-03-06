require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = users(:andres)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Roman's Webblog Account Activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@webblog.com"], mail.from
    assert_match user.name, mail.body.encoded
    assert_match user.activation_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
    assert_match "Hi", mail.body.encoded
  end

  test "password_reset" do
  end

end
