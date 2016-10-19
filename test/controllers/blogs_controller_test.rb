require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest
  # TODO make sure blog_owner actually prevents updates and destroys regardless
  # of webpages (basically just send the action without a browser) - i'm hoping
  # that what happens is they end up sending the update/destroy command to the
  # wrong route (in this case, the index) or something better through rails
  # hidden magicism
end
