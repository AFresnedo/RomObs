require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid user signup information" do
    get signup_path #not necessary, but some conceptual value
    #this is a cool bit of ruby programming, where you encase a bit
    # of test code in a block for assert_no_difference to work on
    # instead of all the crap of getting/saving/comparing the value
    # changing...assert_no_difference does it for you provided you
    # hand it the necessary code to do the action, very cool!
    assert_no_difference 'User.count' do
      #note that posting to users_path DOES ensure this action
      # is happening on the website, you're using the website
      # as the interface for changing the database just not using
      # a browser
      post signup_path, params: { user: { name: "",
                                         email: "user@invalid",
                                         password:      "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new' #failed submission redraws user/new
    #i don't think i understand what assert_template does, it must only
    # check if user/new was rendered...not the actual content of it
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    # whereas this checks the content
    #note: need to learn the syntax for identifying css elements,
    # looked VERY complicated/mysterious (the identifications) when
    # i was trying to fix the bugs...do i need to do a course on css?
    # or skim a chapter(s)? just for a little comfortability/context
    # honestly, yeah, probably, don't worry about it for now just do it
    # in a timely matter during your fullstack work
    # ALSO To be fair if you made a perfect match then this integration test_helper
    # would crash as soon as somebody changed the look/feel of the errors
    # and that's bad not good, better to just check the EXISTANCE of it rather
    # than the nature
    assert_select 'form[action="/signup"]'
  end

  test "valid user signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name: "Andros Testman",
                                          email: "imvalid@bro.com",
                                          password: "thisoneworks",
                                          password_confirmation: "thisoneworks"
                                        }
                                }
    end
    follow_redirect!
    # assert_template 'users/show'
    assert_select 'div.alert-info'
    assert_not flash.empty?
    # assert is_logged_in?
  end
end
