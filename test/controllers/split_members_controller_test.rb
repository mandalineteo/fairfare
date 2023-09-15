require "test_helper"

class SplitMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get split_members_new_url
    assert_response :success
  end
end
