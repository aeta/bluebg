require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase
  test "should get link_through" do
    get :link_through
    assert_response :success
  end

end
