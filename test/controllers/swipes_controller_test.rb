require "test_helper"

class SwipesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get swipes_create_url
    assert_response :success
  end
end
