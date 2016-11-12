require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase
  test "should get follow_user" do
    get :follow_user
    assert_response :success
  end

  test "should get unfollow_user" do
    get :unfollow_user
    assert_response :success
  end

end
