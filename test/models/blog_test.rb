require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  def setup
    @basic = blogs(:basic)
  end

  test "descript is less than 201 characters" do
    assert @basic.valid?
    @basic.descript = 'a' * 200
    assert @basic.valid?
    @basic.descript = 'a' * 201
    assert_not @basic.valid?
  end

  test "all blogs have non-blank titles" do
    assert @basic.valid?
    @basic.title = "   "
    assert_not @basic.valid?
  end

  test "blog titles less than 100 characters" do
    assert @basic.valid?
    @basic.title = 'a' * 101
    assert_not @basic.valid?
    @basic.title = 'a' * 100
    assert @basic.valid?
  end

  test "blog content not empty" do
    assert @basic.valid?
    @basic.body = "           "
    assert_not @basic.valid?
  end

  test "blogs retrieved in desc created order" do
    assert_equal Blog.last, blogs(:oldest)
    Blog.last.destroy
    assert_equal Blog.last, blogs(:old)
  end

  test "topic is less than 21 characters" do
    assert @basic.valid?
    @basic.topic = 'a' * 21
    assert_not @basic.valid?
  end

end
