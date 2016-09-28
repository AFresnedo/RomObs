require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title test helper" do
    assert_equal full_title, "Roman's Observatory"
    assert_equal full_title("Test"), "Test" + " | " +
                                  "Roman's Observatory"
  end
end
