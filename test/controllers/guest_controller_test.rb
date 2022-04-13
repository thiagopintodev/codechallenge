require "test_helper"

class GuestControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get guest_root_url
    assert_response :success
  end
end
