require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:andres)
    @other_user = users(:archer)
  end
end
