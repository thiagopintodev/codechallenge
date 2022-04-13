require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get user_root_url
    assert_response :redirect
  end
end
