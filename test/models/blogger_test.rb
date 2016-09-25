require 'test_helper'

class BloggerTest < ActiveSupport::TestCase
  def setup
    @valid = bloggers(:valid)
  end

  # email validations

  test "valid emails pass" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @valid.email = valid_address
      assert @valid.valid?
    end
  end

  test "emails should be saved all lowercase" do
    mixed_case_email = "nOT.All@LowercASE.net"
    @valid.email = mixed_case_email
    @valid.save
    @valid.reload
    assert_equal @valid.email, mixed_case_email.downcase
  end

  test "emails should not be blank" do
    @valid.email = "  "
    @valid.valid?
  end

  test "emails should not be empty" do
    @valid.email = ""
    assert_not @valid.valid?
  end

  test "emails should be case-insensitive unique" do
    assert @valid.valid?
    cloneUser = Blogger.new(name: "clone", email: @valid.email.upcase)
    assert @valid.valid?
    assert_not cloneUser.valid?
  end

  # name validations

  test "valid names should pass" do
    valid_names = ["Henry the Fifth", "Johnjacobson", "lancaster676"]
    valid_names.each do |valid_name|
      @valid.name = valid_name
      assert @valid.valid?
    end
  end

  test "email should not be too long" do
    @valid.email = 'a' * 255
    assert_not @valid.valid?
  end

  test "name should not be blank" do
    @valid.name = "    "
    assert_not @valid.valid?
  end

  test "name should not be empty" do
    @valid.name = ""
    assert_not @valid.valid?
  end

  test "name should not be too long" do
    @valid.name = 'a' * 51
    assert_not @valid.valid?
  end

  test "email name should be sane" do
  end
end
